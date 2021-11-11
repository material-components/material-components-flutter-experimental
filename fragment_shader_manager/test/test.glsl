#version 310 es

precision highp float;

layout(location = 0) uniform vec2 u_resolution;
layout(location = 1) uniform float u_time;
layout(location = 2) uniform float u_rad;

layout(location = 0) out vec4 fragColor;

const float PI = 3.1415926535897932384626;

void main() {
  vec2 uv = gl_FragCoord.xy / u_resolution.xy;

  float r = triangle_noise(uv + vec2(0.1, 0.2));
  float g = triangle_noise(uv * vec2(0.1, 0.1));
  float b = triangle_noise(uv * vec2(0.2, 0.1));
  vec4 color = vec4(r, g, b, 1.0);

  float sparkle = sparkles(uv, u_time);
  fragColor = color * sparkle;
}

float triangle_noise(highp vec2 n) {
  n = fract(n * vec2(5.3987, 5.4421));
  n += dot(n.yx, n.xy + vec2(21.5351, 14.3137));
  highp float xy = n.x * n.y;
  return fract(xy * 95.4307) + fract(xy * 75.04961) - 1.0;
}

float sparkles(vec2 uv, float t) {
  float n = triangle_noise(uv);
  float s = 0.0;

  // TODO(clocksmith): Still a bug with for loops...
  // for (float i = 0.0; i < 4.0; i += 1.0) {
  //   float l = i * 0.1;
  //   float h = l + 0.05;
  //   float o = sin(PI * (t + 0.35 * i));
  //   s += threshold(n + o, l, h);
  // }

  // Manually unroll for loop
  // TODO(antrob): Remove this once for loops work.

  float l0 = 0.0 * 0.1;
  float h0 = l0 + 0.05;
  float o0 = sin(PI * (t + 0.35 * 0.0));
  s += threshold(n + o0, l0, h0);

  float l1 = 1.0 * 0.1;
  float h1 = l1 + 0.05;
  float o1 = sin(PI * (t + 0.35 * 1.0));
  s += threshold(n + o1, l1, h1);

  float l2 = 2.0 * 0.1;
  float h2 = l2 + 0.05;
  float o2 = sin(PI * (t + 0.35 * 2.0));
  s += threshold(n + o2, l2, h2);

  float l3 = 3.0 * 0.1;
  float h3 = l3 + 0.05;
  float o3 = sin(PI * (t + 0.35 * 3.0));
  s += threshold(n + o3, l3, h3);

  return clamp(s, 0.0, 1.0);
}

float threshold(float v, float l, float h) {
  return step(l, v) * (1.0 - step(h, v));
}