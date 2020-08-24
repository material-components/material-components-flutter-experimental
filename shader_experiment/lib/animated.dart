// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickingFragmentShader extends StatefulWidget {
  TickingFragmentShader({this.sksl});

  final String sksl;

  @override
  _TickingFragmentShaderState createState() => _TickingFragmentShaderState();
}

class _TickingFragmentShaderState extends State<TickingFragmentShader> {
  double _time; // millis
  FragmentShader _shader;
  Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _shader = FragmentShader(widget.sksl);
    _ticker =Ticker((duration) {
      setState(() {
        _time = duration.inMicroseconds / 1000.0;
      });
    })..start();
  }

  @override
  void dispose() {
    _ticker.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomPainterWithTime(shader: _shader, time: _time),
    );
  }
}

class CustomPainterWithTime extends CustomPainter {
  CustomPainterWithTime({this.shader, this.time});

  final FragmentShader shader;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setTime(time);
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(CustomPainterWithTime oldDelegate) {
    return oldDelegate.time != time;
  }
}

class AnimatedSolidColorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: TickingFragmentShader(
            sksl: '''
              uniform float t;
            
              void main(float2 xy, inout half4 color) {
                color = half4(half(sin(t / 1000.0)), 0.0, 1.0, 1.0);
              }
            ''',
          ),
        ),
      ),
    );
  }
}

class AnimatedSpiral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: TickingFragmentShader(
            sksl: '''
        uniform float t;

        void main(float2 p, inout half4 color) {
            float rad_scale = sin(t / 1000.0 * 0.5 + 2.0) / 5.0;
            float2 in_center = float2(150.0, 150.0);
            float4 in_colors0 = float4(1.0, 0.0, 1.0, 1.0);
            float4 in_colors1 = float4(0.0, 1.0, 1.0, 1.0);
            float2 pp = p - in_center;
            float radius = length(pp);
            radius = sqrt(radius);
            float angle = atan(pp.y / pp.x);
            float tt = (angle + 3.1415926/2) / (3.1415926);
            tt += radius * rad_scale;
            tt = fract(tt);
            float4 m = in_colors0 * (1-tt) + in_colors1 * tt;
            color = half4(m);
        }
            ''',
          ),
        ),
      ),
    );
  }
}

// Ported from https://www.shadertoy.com/view/3l23Rh to SKSL
// TODO: compile with named functions?
class ProteanClouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: TickingFragmentShader(
            sksl: '''
// Protean clouds by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/3l23Rh
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// Contact the author for other licensing options

/*
	Technical details:

	The main volume noise is generated from a deformed periodic grid, which can produce
	a large range of noise-like patterns at very cheap evalutation cost. Allowing for multiple
	fetches of volume gradient computation for improved lighting.

	To further accelerate marching, since the volume is smooth, more than half the the density
	information isn't used to rendering or shading but only as an underlying volume	distance to 
	determine dynamic step size, by carefully selecting an equation	(polynomial for speed) to 
	step as a function of overall density (not necessarialy rendered) the visual results can be 
	the	same as a naive implementation with ~40% increase in rendering performance.

	Since the dynamic marching step size is even less uniform due to steps not being rendered at all
	the fog is evaluated as the difference of the fog integral at each rendered step.

*/
uniform float t;

float2x2 rot(in float a){float c = cos(a), s = sin(a);return float2x2(c,s,-s,c);}
const float3x3 m3 = float3x3(0.33338, 0.56034, -0.71817, -0.87887, 0.32651, -0.15323, 0.15162, 0.69596, 0.61339)*1.93;
float mag2(float2 p){return dot(p,p);}
float linstep(in float mn, in float mx, in float x){ return clamp((x - mn)/(mx - mn), 0., 1.); }
float prm1 = 0.;
float2 bsMo = float2(0);

float2 disp(float t){ return float2(sin(t*0.22)*1., cos(t*0.175)*1.)*2.; }

float2 map(float3 p)
{
    float3 p2 = p;
    p2.xy -= disp(p.z).xy;
    p.xy *= rot(sin(p.z+iTime)*(0.1 + prm1*0.05) + iTime*0.09);
    float cl = mag2(p2.xy);
    float d = 0.;
    p *= .61;
    float z = 1.;
    float trk = 1.;
    float dspAmp = 0.1 + prm1*0.2;
    for(int i = 0; i < 5; i++)
    {
		p += sin(p.zxy*0.75*trk + iTime*trk*.8)*dspAmp;
        d -= abs(dot(cos(p), sin(p.yzx))*z);
        z *= 0.57;
        trk *= 1.4;
        p = p*m3;
    }
    d = abs(d + prm1*3.)+ prm1*.3 - 2.5 + bsMo.y;
    return float2(d + cl*.2 + 0.25, cl);
}

float4 render( in float3 ro, in float3 rd, float time )
{
	float4 rez = float4(0);
    const float ldst = 8.;
	float3 lpos = float3(disp(time + ldst)*0.5, time + ldst);
	float t = 1.5;
	float fogT = 0.;
	for(int i=0; i<130; i++)
	{
		if(rez.a > 0.99)break;

		float3 pos = ro + t*rd;
        float2 mpv = map(pos);
		float den = clamp(mpv.x-0.3,0.,1.)*1.12;
		float dn = clamp((mpv.x + 2.),0.,3.);
        
		float4 col = float4(0);
        if (mpv.x > 0.6)
        {
        
            col = float4(sin(float3(5.,0.4,0.2) + mpv.y*0.1 +sin(pos.z*0.4)*0.5 + 1.8)*0.5 + 0.5,0.08);
            col *= den*den*den;
			col.rgb *= linstep(4.,-2.5, mpv.x)*2.3;
            float dif =  clamp((den - map(pos+.8).x)/9., 0.001, 1. );
            dif += clamp((den - map(pos+.35).x)/2.5, 0.001, 1. );
            col.xyz *= den*(float3(0.005,.045,.075) + 1.5*float3(0.033,0.07,0.03)*dif);
        }
		
		float fogC = exp(t*0.2 - 2.2);
		col.rgba += float4(0.06,0.11,0.11, 0.1)*clamp(fogC-fogT, 0., 1.);
		fogT = fogC;
		rez = rez + col*(1. - rez.a);
		t += clamp(0.5 - dn*dn*.05, 0.09, 0.3);
	}
	return clamp(rez, 0.0, 1.0);
}

float getsat(float3 c)
{
    float mi = min(min(c.x, c.y), c.z);
    float ma = max(max(c.x, c.y), c.z);
    return (ma - mi)/(ma+ 1e-7);
}

//from my "Will it blend" shader (https://www.shadertoy.com/view/lsdGzN)
float3 iLerp(in float3 a, in float3 b, in float x)
{
    float3 ic = mix(a, b, x) + float3(1e-6,0.,0.);
    float sd = abs(getsat(ic) - mix(getsat(a), getsat(b), x));
    float3 dir = normalize(float3(2.*ic.x - ic.y - ic.z, 2.*ic.y - ic.x - ic.z, 2.*ic.z - ic.y - ic.x));
    float lgt = dot(float3(1.0), ic);
    float ff = dot(dir, normalize(ic));
    ic += 1.5*dir*sd*ff*lgt;
    return clamp(ic,0.,1.);
}

void main( float2 fragCoord, inout half4 fragColor )
{	
  float2 iResolution = float2(300, 300);
	float2 q = fragCoord/iResolution;
    float2 p = (fragCoord - 0.5*iResolution)/iResolution.y;
    
    float iTime = t;
    float time = iTime*3.;
    float3 ro = float3(0,0,time);
    
    ro += float3(sin(iTime)*0.5,sin(iTime*1.)*0.,0);
        
    float dspAmp = .85;
    ro.xy += disp(ro.z)*dspAmp;
    float tgtDst = 3.5;
    
    float3 target = normalize(ro - float3(disp(time + tgtDst)*dspAmp, time + tgtDst));
    float3 rightdir = normalize(cross(target, float3(0,1,0)));
    float3 updir = normalize(cross(rightdir, target));
    rightdir = normalize(cross(updir, target));
	float3 rd=normalize((p.x*rightdir + p.y*updir)*1. - target);
    rd.xy *= rot(-disp(time + 3.5).x*0.2);
    prm1 = smoothstep(-0.4, 0.4,sin(iTime*0.3));
	float4 scn = render(ro, rd, time);
		
    float3 col = scn.rgb;
    col = iLerp(col.bgr, col.rgb, clamp(1.-prm1,0.05,1.));
    
    col = pow(col, float3(.55,0.65,0.6))*float3(1.,.97,.9);

    col *= pow( 16.0*q.x*q.y*(1.0-q.x)*(1.0-q.y), 0.12)*0.7+0.3; //Vign
    
	fragColor = float4( col, 1.0 );
}
            ''',
          ),
        ),
      ),
    );
  }
}