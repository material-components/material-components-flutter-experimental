// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:flutter/material.dart';

import '../api.dart';

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
                color = half4(half((sin(t * 3.1415926) + 1.0) / 2.0), 0.0, 1.0, 1.0);
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
            float rad_scale = sin(t + 2.0) / 5.0;
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