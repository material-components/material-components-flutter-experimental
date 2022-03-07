// GENERATED FILE - DO NOT EDIT

// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:vector_math/vector_math_64.dart';

/// A class for managing [FragmentProgram] that includes a pre-transpiled
/// shader program into SPIR-V.
class FragmentShaderManager {
  static Future<FragmentShaderManager> test() async {
    final manager = FragmentShaderManager._();
    await manager.compile();
    return manager;
  }

  FragmentShaderManager._();

  Future<void> compile() async {
    _program = await ui.FragmentProgram.compile(spirv: spirvByteBuffer);
  }

  /// Creates a shader with the original program and optional uniforms.
  /// 
  /// A new shader must be made whenever the uniforms are updated.
  shader({
    Vector2? uResolution,
    double? uTime,
    double? uRad,
  }) {
    return _program.shader(
      floatUniforms: Float32List.fromList([
        ...uResolution != null ? uResolution.storage : [0, 0],
        ...uTime != null ? [uTime] : [0],
        ...uRad != null ? [uRad] : [0],
      ]),
    );
  }
  
  late ui.FragmentProgram _program;

  /// Direct access to the [ui.FragmentProgram] that this class manages.
  /// 
  /// In general, this is not needed, but may be useful for debugging or edge cases.
  ui.FragmentProgram get program => _program;

  /// Direct access to the source GLSL that was used to generate this class.
  /// 
  /// In general, this is not needed, but may be useful for debugging or edge cases.
  String get glsl => _glslString;

  /// Direct access to the the SPIR-V bytecode that was used to generate this class.
  /// 
  /// In general, this is not needed, but may be useful for debugging or edge cases.
  ///
  /// Words in SPIR-V are 32 bits. Every 4 elements in this list represents 1
  /// SPIR-V word. See https://www.khronos.org/registry/SPIR-V/.
  ByteBuffer get spirvByteBuffer => Uint8List.fromList(_spirvByteList).buffer;
}

const _glslString = '''
#version 310 es

precision highp float;

layout(location = 0) uniform vec2 u_resolution;
layout(location = 1) uniform float u_time;
layout(location = 2) uniform float u_rad;

layout(location = 0) out vec4 fragColor;

const float PI = 3.1415926535897932384626;

float triangle_noise(highp vec2 n) {
  n = fract(n * vec2(5.3987, 5.4421));
  n += dot(n.yx, n.xy + vec2(21.5351, 14.3137));
  highp float xy = n.x * n.y;
  return fract(xy * 95.4307) + fract(xy * 75.04961) - 1.0;
}

float threshold(float v, float l, float h) {
  return step(l, v) * (1.0 - step(h, v));
}

float sparkles(vec2 uv, float t) {
  float n = triangle_noise(uv);
  float s = 0.0;

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

void main() {
  vec2 uv = gl_FragCoord.xy / u_resolution.xy;

  float r = triangle_noise(uv + vec2(0.1, 0.2));
  float g = triangle_noise(uv * vec2(0.1, 0.1));
  float b = triangle_noise(uv * vec2(0.2, 0.1));
  vec4 color = vec4(r, g, b, 1.0);

  float sparkle = sparkles(uv, u_time);
  fragColor = color * sparkle;
}

''';

const _spirvByteList = [0x03,0x02,0x23,0x07,0x00,0x00,0x01,0x00,0x0A,0x00,0x0D,0x00,0xDC,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x11,0x00,0x02,0x00,0x01,0x00,0x00,0x00,0x0B,0x00,0x06,0x00,0x01,0x00,0x00,0x00,0x47,0x4C,0x53,0x4C,0x2E,0x73,0x74,0x64,0x2E,0x34,0x35,0x30,0x00,0x00,0x00,0x00,0x0E,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0F,0x00,0x07,0x00,0x04,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x6D,0x61,0x69,0x6E,0x00,0x00,0x00,0x00,0xAF,0x00,0x00,0x00,0xD7,0x00,0x00,0x00,0x10,0x00,0x03,0x00,0x04,0x00,0x00,0x00,0x08,0x00,0x00,0x00,0x03,0x00,0x03,0x00,0x01,0x00,0x00,0x00,0x36,0x01,0x00,0x00,0x04,0x00,0x0A,0x00,0x47,0x4C,0x5F,0x47,0x4F,0x4F,0x47,0x4C,0x45,0x5F,0x63,0x70,0x70,0x5F,0x73,0x74,0x79,0x6C,0x65,0x5F,0x6C,0x69,0x6E,0x65,0x5F,0x64,0x69,0x72,0x65,0x63,0x74,0x69,0x76,0x65,0x00,0x00,0x04,0x00,0x08,0x00,0x47,0x4C,0x5F,0x47,0x4F,0x4F,0x47,0x4C,0x45,0x5F,0x69,0x6E,0x63,0x6C,0x75,0x64,0x65,0x5F,0x64,0x69,0x72,0x65,0x63,0x74,0x69,0x76,0x65,0x00,0x05,0x00,0x04,0x00,0x04,0x00,0x00,0x00,0x6D,0x61,0x69,0x6E,0x00,0x00,0x00,0x00,0x05,0x00,0x07,0x00,0x0B,0x00,0x00,0x00,0x74,0x72,0x69,0x61,0x6E,0x67,0x6C,0x65,0x5F,0x6E,0x6F,0x69,0x73,0x65,0x28,0x76,0x66,0x32,0x3B,0x00,0x05,0x00,0x03,0x00,0x0A,0x00,0x00,0x00,0x6E,0x00,0x00,0x00,0x05,0x00,0x07,0x00,0x12,0x00,0x00,0x00,0x74,0x68,0x72,0x65,0x73,0x68,0x6F,0x6C,0x64,0x28,0x66,0x31,0x3B,0x66,0x31,0x3B,0x66,0x31,0x3B,0x00,0x05,0x00,0x03,0x00,0x0F,0x00,0x00,0x00,0x76,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x10,0x00,0x00,0x00,0x6C,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x11,0x00,0x00,0x00,0x68,0x00,0x00,0x00,0x05,0x00,0x07,0x00,0x17,0x00,0x00,0x00,0x73,0x70,0x61,0x72,0x6B,0x6C,0x65,0x73,0x28,0x76,0x66,0x32,0x3B,0x66,0x31,0x3B,0x00,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x15,0x00,0x00,0x00,0x75,0x76,0x00,0x00,0x05,0x00,0x03,0x00,0x16,0x00,0x00,0x00,0x74,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x2A,0x00,0x00,0x00,0x78,0x79,0x00,0x00,0x05,0x00,0x03,0x00,0x4A,0x00,0x00,0x00,0x6E,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0x4B,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x4E,0x00,0x00,0x00,0x73,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x50,0x00,0x00,0x00,0x6C,0x30,0x00,0x00,0x05,0x00,0x03,0x00,0x51,0x00,0x00,0x00,0x68,0x30,0x00,0x00,0x05,0x00,0x03,0x00,0x55,0x00,0x00,0x00,0x6F,0x30,0x00,0x00,0x05,0x00,0x04,0x00,0x5E,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0x5F,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0x61,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x66,0x00,0x00,0x00,0x6C,0x31,0x00,0x00,0x05,0x00,0x03,0x00,0x68,0x00,0x00,0x00,0x68,0x31,0x00,0x00,0x05,0x00,0x03,0x00,0x6B,0x00,0x00,0x00,0x6F,0x31,0x00,0x00,0x05,0x00,0x04,0x00,0x74,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0x75,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0x77,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x7C,0x00,0x00,0x00,0x6C,0x32,0x00,0x00,0x05,0x00,0x03,0x00,0x7E,0x00,0x00,0x00,0x68,0x32,0x00,0x00,0x05,0x00,0x03,0x00,0x81,0x00,0x00,0x00,0x6F,0x32,0x00,0x00,0x05,0x00,0x04,0x00,0x8A,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0x8B,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0x8D,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0x92,0x00,0x00,0x00,0x6C,0x33,0x00,0x00,0x05,0x00,0x03,0x00,0x94,0x00,0x00,0x00,0x68,0x33,0x00,0x00,0x05,0x00,0x03,0x00,0x97,0x00,0x00,0x00,0x6F,0x33,0x00,0x00,0x05,0x00,0x04,0x00,0xA0,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xA1,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xA3,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0xAC,0x00,0x00,0x00,0x75,0x76,0x00,0x00,0x05,0x00,0x06,0x00,0xAF,0x00,0x00,0x00,0x67,0x6C,0x5F,0x46,0x72,0x61,0x67,0x43,0x6F,0x6F,0x72,0x64,0x00,0x00,0x00,0x00,0x05,0x00,0x06,0x00,0xB3,0x00,0x00,0x00,0x75,0x5F,0x72,0x65,0x73,0x6F,0x6C,0x75,0x74,0x69,0x6F,0x6E,0x00,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0xB6,0x00,0x00,0x00,0x72,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xBA,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0xBC,0x00,0x00,0x00,0x67,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xC0,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x03,0x00,0xC2,0x00,0x00,0x00,0x62,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xC6,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xC9,0x00,0x00,0x00,0x63,0x6F,0x6C,0x6F,0x72,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xCE,0x00,0x00,0x00,0x73,0x70,0x61,0x72,0x6B,0x6C,0x65,0x00,0x05,0x00,0x04,0x00,0xD0,0x00,0x00,0x00,0x75,0x5F,0x74,0x69,0x6D,0x65,0x00,0x00,0x05,0x00,0x04,0x00,0xD1,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xD3,0x00,0x00,0x00,0x70,0x61,0x72,0x61,0x6D,0x00,0x00,0x00,0x05,0x00,0x05,0x00,0xD7,0x00,0x00,0x00,0x66,0x72,0x61,0x67,0x43,0x6F,0x6C,0x6F,0x72,0x00,0x00,0x00,0x05,0x00,0x04,0x00,0xDB,0x00,0x00,0x00,0x75,0x5F,0x72,0x61,0x64,0x00,0x00,0x00,0x47,0x00,0x04,0x00,0xAF,0x00,0x00,0x00,0x0B,0x00,0x00,0x00,0x0F,0x00,0x00,0x00,0x47,0x00,0x04,0x00,0xB3,0x00,0x00,0x00,0x1E,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x47,0x00,0x04,0x00,0xD0,0x00,0x00,0x00,0x1E,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x47,0x00,0x04,0x00,0xD7,0x00,0x00,0x00,0x1E,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x47,0x00,0x04,0x00,0xDB,0x00,0x00,0x00,0x1E,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x13,0x00,0x02,0x00,0x02,0x00,0x00,0x00,0x21,0x00,0x03,0x00,0x03,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x16,0x00,0x03,0x00,0x06,0x00,0x00,0x00,0x20,0x00,0x00,0x00,0x17,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x20,0x00,0x04,0x00,0x08,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x21,0x00,0x04,0x00,0x09,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x08,0x00,0x00,0x00,0x20,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x21,0x00,0x06,0x00,0x0E,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x21,0x00,0x05,0x00,0x14,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x08,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x1A,0x00,0x00,0x00,0x27,0xC2,0xAC,0x40,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x1B,0x00,0x00,0x00,0xAF,0x25,0xAE,0x40,0x2C,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0x1C,0x00,0x00,0x00,0x1A,0x00,0x00,0x00,0x1B,0x00,0x00,0x00,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x22,0x00,0x00,0x00,0xE3,0x47,0xAC,0x41,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x23,0x00,0x00,0x00,0xEA,0x04,0x65,0x41,0x2C,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0x24,0x00,0x00,0x00,0x22,0x00,0x00,0x00,0x23,0x00,0x00,0x00,0x15,0x00,0x04,0x00,0x2B,0x00,0x00,0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x2B,0x00,0x04,0x00,0x2B,0x00,0x00,0x00,0x2C,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x2B,0x00,0x04,0x00,0x2B,0x00,0x00,0x00,0x2F,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x34,0x00,0x00,0x00,0x85,0xDC,0xBE,0x42,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x38,0x00,0x00,0x00,0x66,0x19,0x96,0x42,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x3C,0x00,0x00,0x00,0x00,0x00,0x80,0x3F,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x4F,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x53,0x00,0x00,0x00,0xCD,0xCC,0x4C,0x3D,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x56,0x00,0x00,0x00,0xDB,0x0F,0x49,0x40,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x67,0x00,0x00,0x00,0xCD,0xCC,0xCC,0x3D,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x6D,0x00,0x00,0x00,0x33,0x33,0xB3,0x3E,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x7D,0x00,0x00,0x00,0xCD,0xCC,0x4C,0x3E,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x83,0x00,0x00,0x00,0x33,0x33,0x33,0x3F,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x93,0x00,0x00,0x00,0x9A,0x99,0x99,0x3E,0x2B,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x99,0x00,0x00,0x00,0x66,0x66,0x86,0x3F,0x17,0x00,0x04,0x00,0xAD,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x20,0x00,0x04,0x00,0xAE,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0xAD,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0xAE,0x00,0x00,0x00,0xAF,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x20,0x00,0x04,0x00,0xB2,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0xB2,0x00,0x00,0x00,0xB3,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x2C,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0xB8,0x00,0x00,0x00,0x67,0x00,0x00,0x00,0x7D,0x00,0x00,0x00,0x2C,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0xBE,0x00,0x00,0x00,0x67,0x00,0x00,0x00,0x67,0x00,0x00,0x00,0x2C,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0xC4,0x00,0x00,0x00,0x7D,0x00,0x00,0x00,0x67,0x00,0x00,0x00,0x20,0x00,0x04,0x00,0xC8,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0xAD,0x00,0x00,0x00,0x20,0x00,0x04,0x00,0xCF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0xCF,0x00,0x00,0x00,0xD0,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x20,0x00,0x04,0x00,0xD6,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0xAD,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0xD6,0x00,0x00,0x00,0xD7,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0xCF,0x00,0x00,0x00,0xDB,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x36,0x00,0x05,0x00,0x02,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0xF8,0x00,0x02,0x00,0x05,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x08,0x00,0x00,0x00,0xAC,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xB6,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x08,0x00,0x00,0x00,0xBA,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xBC,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x08,0x00,0x00,0x00,0xC0,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xC2,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x08,0x00,0x00,0x00,0xC6,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0xC8,0x00,0x00,0x00,0xC9,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xCE,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x08,0x00,0x00,0x00,0xD1,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xD3,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0xAD,0x00,0x00,0x00,0xB0,0x00,0x00,0x00,0xAF,0x00,0x00,0x00,0x4F,0x00,0x07,0x00,0x07,0x00,0x00,0x00,0xB1,0x00,0x00,0x00,0xB0,0x00,0x00,0x00,0xB0,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0xB4,0x00,0x00,0x00,0xB3,0x00,0x00,0x00,0x88,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0xB5,0x00,0x00,0x00,0xB1,0x00,0x00,0x00,0xB4,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xAC,0x00,0x00,0x00,0xB5,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0xB7,0x00,0x00,0x00,0xAC,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0xB9,0x00,0x00,0x00,0xB7,0x00,0x00,0x00,0xB8,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xBA,0x00,0x00,0x00,0xB9,0x00,0x00,0x00,0x39,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0xBB,0x00,0x00,0x00,0x0B,0x00,0x00,0x00,0xBA,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xB6,0x00,0x00,0x00,0xBB,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0xBD,0x00,0x00,0x00,0xAC,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0xBF,0x00,0x00,0x00,0xBD,0x00,0x00,0x00,0xBE,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xC0,0x00,0x00,0x00,0xBF,0x00,0x00,0x00,0x39,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0xC1,0x00,0x00,0x00,0x0B,0x00,0x00,0x00,0xC0,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xBC,0x00,0x00,0x00,0xC1,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0xC3,0x00,0x00,0x00,0xAC,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0xC5,0x00,0x00,0x00,0xC3,0x00,0x00,0x00,0xC4,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xC6,0x00,0x00,0x00,0xC5,0x00,0x00,0x00,0x39,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0xC7,0x00,0x00,0x00,0x0B,0x00,0x00,0x00,0xC6,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xC2,0x00,0x00,0x00,0xC7,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xCA,0x00,0x00,0x00,0xB6,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xCB,0x00,0x00,0x00,0xBC,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xCC,0x00,0x00,0x00,0xC2,0x00,0x00,0x00,0x50,0x00,0x07,0x00,0xAD,0x00,0x00,0x00,0xCD,0x00,0x00,0x00,0xCA,0x00,0x00,0x00,0xCB,0x00,0x00,0x00,0xCC,0x00,0x00,0x00,0x3C,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xC9,0x00,0x00,0x00,0xCD,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0xD2,0x00,0x00,0x00,0xAC,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xD1,0x00,0x00,0x00,0xD2,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xD4,0x00,0x00,0x00,0xD0,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xD3,0x00,0x00,0x00,0xD4,0x00,0x00,0x00,0x39,0x00,0x06,0x00,0x06,0x00,0x00,0x00,0xD5,0x00,0x00,0x00,0x17,0x00,0x00,0x00,0xD1,0x00,0x00,0x00,0xD3,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xCE,0x00,0x00,0x00,0xD5,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0xAD,0x00,0x00,0x00,0xD8,0x00,0x00,0x00,0xC9,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xD9,0x00,0x00,0x00,0xCE,0x00,0x00,0x00,0x8E,0x00,0x05,0x00,0xAD,0x00,0x00,0x00,0xDA,0x00,0x00,0x00,0xD8,0x00,0x00,0x00,0xD9,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xD7,0x00,0x00,0x00,0xDA,0x00,0x00,0x00,0xFD,0x00,0x01,0x00,0x38,0x00,0x01,0x00,0x36,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x0B,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x09,0x00,0x00,0x00,0x37,0x00,0x03,0x00,0x08,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0xF8,0x00,0x02,0x00,0x0C,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x2A,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0x19,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0x1D,0x00,0x00,0x00,0x19,0x00,0x00,0x00,0x1C,0x00,0x00,0x00,0x0C,0x00,0x06,0x00,0x07,0x00,0x00,0x00,0x1E,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x1D,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x0A,0x00,0x00,0x00,0x1E,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0x1F,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x4F,0x00,0x07,0x00,0x07,0x00,0x00,0x00,0x20,0x00,0x00,0x00,0x1F,0x00,0x00,0x00,0x1F,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0x21,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0x25,0x00,0x00,0x00,0x21,0x00,0x00,0x00,0x24,0x00,0x00,0x00,0x94,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x26,0x00,0x00,0x00,0x20,0x00,0x00,0x00,0x25,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0x27,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x50,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0x28,0x00,0x00,0x00,0x26,0x00,0x00,0x00,0x26,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x07,0x00,0x00,0x00,0x29,0x00,0x00,0x00,0x27,0x00,0x00,0x00,0x28,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x0A,0x00,0x00,0x00,0x29,0x00,0x00,0x00,0x41,0x00,0x05,0x00,0x0D,0x00,0x00,0x00,0x2D,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x2C,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x2E,0x00,0x00,0x00,0x2D,0x00,0x00,0x00,0x41,0x00,0x05,0x00,0x0D,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x2F,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x31,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x32,0x00,0x00,0x00,0x2E,0x00,0x00,0x00,0x31,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x2A,0x00,0x00,0x00,0x32,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x33,0x00,0x00,0x00,0x2A,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x35,0x00,0x00,0x00,0x33,0x00,0x00,0x00,0x34,0x00,0x00,0x00,0x0C,0x00,0x06,0x00,0x06,0x00,0x00,0x00,0x36,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x35,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x37,0x00,0x00,0x00,0x2A,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x39,0x00,0x00,0x00,0x37,0x00,0x00,0x00,0x38,0x00,0x00,0x00,0x0C,0x00,0x06,0x00,0x06,0x00,0x00,0x00,0x3A,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0A,0x00,0x00,0x00,0x39,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x3B,0x00,0x00,0x00,0x36,0x00,0x00,0x00,0x3A,0x00,0x00,0x00,0x83,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x3D,0x00,0x00,0x00,0x3B,0x00,0x00,0x00,0x3C,0x00,0x00,0x00,0xFE,0x00,0x02,0x00,0x3D,0x00,0x00,0x00,0x38,0x00,0x01,0x00,0x36,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x12,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0E,0x00,0x00,0x00,0x37,0x00,0x03,0x00,0x0D,0x00,0x00,0x00,0x0F,0x00,0x00,0x00,0x37,0x00,0x03,0x00,0x0D,0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x37,0x00,0x03,0x00,0x0D,0x00,0x00,0x00,0x11,0x00,0x00,0x00,0xF8,0x00,0x02,0x00,0x13,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x40,0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x41,0x00,0x00,0x00,0x0F,0x00,0x00,0x00,0x0C,0x00,0x07,0x00,0x06,0x00,0x00,0x00,0x42,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x40,0x00,0x00,0x00,0x41,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x43,0x00,0x00,0x00,0x11,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x44,0x00,0x00,0x00,0x0F,0x00,0x00,0x00,0x0C,0x00,0x07,0x00,0x06,0x00,0x00,0x00,0x45,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x43,0x00,0x00,0x00,0x44,0x00,0x00,0x00,0x83,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x46,0x00,0x00,0x00,0x3C,0x00,0x00,0x00,0x45,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x47,0x00,0x00,0x00,0x42,0x00,0x00,0x00,0x46,0x00,0x00,0x00,0xFE,0x00,0x02,0x00,0x47,0x00,0x00,0x00,0x38,0x00,0x01,0x00,0x36,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x17,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x00,0x00,0x37,0x00,0x03,0x00,0x08,0x00,0x00,0x00,0x15,0x00,0x00,0x00,0x37,0x00,0x03,0x00,0x0D,0x00,0x00,0x00,0x16,0x00,0x00,0x00,0xF8,0x00,0x02,0x00,0x18,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x4A,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x08,0x00,0x00,0x00,0x4B,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x4E,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x50,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x51,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x55,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x5E,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x5F,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x61,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x66,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x68,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x6B,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x74,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x75,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x77,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x7C,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x7E,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x81,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x8A,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x8B,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x8D,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x92,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x94,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0x97,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xA0,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xA1,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3B,0x00,0x04,0x00,0x0D,0x00,0x00,0x00,0xA3,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x07,0x00,0x00,0x00,0x4C,0x00,0x00,0x00,0x15,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x4B,0x00,0x00,0x00,0x4C,0x00,0x00,0x00,0x39,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x4D,0x00,0x00,0x00,0x0B,0x00,0x00,0x00,0x4B,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x4A,0x00,0x00,0x00,0x4D,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x4E,0x00,0x00,0x00,0x4F,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x50,0x00,0x00,0x00,0x4F,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x52,0x00,0x00,0x00,0x50,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x54,0x00,0x00,0x00,0x52,0x00,0x00,0x00,0x53,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x51,0x00,0x00,0x00,0x54,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x57,0x00,0x00,0x00,0x16,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x58,0x00,0x00,0x00,0x57,0x00,0x00,0x00,0x4F,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x59,0x00,0x00,0x00,0x56,0x00,0x00,0x00,0x58,0x00,0x00,0x00,0x0C,0x00,0x06,0x00,0x06,0x00,0x00,0x00,0x5A,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x59,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x55,0x00,0x00,0x00,0x5A,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x5B,0x00,0x00,0x00,0x4A,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x5C,0x00,0x00,0x00,0x55,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x5D,0x00,0x00,0x00,0x5B,0x00,0x00,0x00,0x5C,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x5E,0x00,0x00,0x00,0x5D,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x60,0x00,0x00,0x00,0x50,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x5F,0x00,0x00,0x00,0x60,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x62,0x00,0x00,0x00,0x51,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x61,0x00,0x00,0x00,0x62,0x00,0x00,0x00,0x39,0x00,0x07,0x00,0x06,0x00,0x00,0x00,0x63,0x00,0x00,0x00,0x12,0x00,0x00,0x00,0x5E,0x00,0x00,0x00,0x5F,0x00,0x00,0x00,0x61,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x64,0x00,0x00,0x00,0x4E,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x65,0x00,0x00,0x00,0x64,0x00,0x00,0x00,0x63,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x4E,0x00,0x00,0x00,0x65,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x66,0x00,0x00,0x00,0x67,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x69,0x00,0x00,0x00,0x66,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x6A,0x00,0x00,0x00,0x69,0x00,0x00,0x00,0x53,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x68,0x00,0x00,0x00,0x6A,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x6C,0x00,0x00,0x00,0x16,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x6E,0x00,0x00,0x00,0x6C,0x00,0x00,0x00,0x6D,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x6F,0x00,0x00,0x00,0x56,0x00,0x00,0x00,0x6E,0x00,0x00,0x00,0x0C,0x00,0x06,0x00,0x06,0x00,0x00,0x00,0x70,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x6F,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x6B,0x00,0x00,0x00,0x70,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x71,0x00,0x00,0x00,0x4A,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x72,0x00,0x00,0x00,0x6B,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x73,0x00,0x00,0x00,0x71,0x00,0x00,0x00,0x72,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x74,0x00,0x00,0x00,0x73,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x76,0x00,0x00,0x00,0x66,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x75,0x00,0x00,0x00,0x76,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x78,0x00,0x00,0x00,0x68,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x77,0x00,0x00,0x00,0x78,0x00,0x00,0x00,0x39,0x00,0x07,0x00,0x06,0x00,0x00,0x00,0x79,0x00,0x00,0x00,0x12,0x00,0x00,0x00,0x74,0x00,0x00,0x00,0x75,0x00,0x00,0x00,0x77,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x7A,0x00,0x00,0x00,0x4E,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x7B,0x00,0x00,0x00,0x7A,0x00,0x00,0x00,0x79,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x4E,0x00,0x00,0x00,0x7B,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x7C,0x00,0x00,0x00,0x7D,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x7F,0x00,0x00,0x00,0x7C,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x7F,0x00,0x00,0x00,0x53,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x7E,0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x82,0x00,0x00,0x00,0x16,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x84,0x00,0x00,0x00,0x82,0x00,0x00,0x00,0x83,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x85,0x00,0x00,0x00,0x56,0x00,0x00,0x00,0x84,0x00,0x00,0x00,0x0C,0x00,0x06,0x00,0x06,0x00,0x00,0x00,0x86,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x85,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x81,0x00,0x00,0x00,0x86,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x87,0x00,0x00,0x00,0x4A,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x88,0x00,0x00,0x00,0x81,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x89,0x00,0x00,0x00,0x87,0x00,0x00,0x00,0x88,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x8A,0x00,0x00,0x00,0x89,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x8C,0x00,0x00,0x00,0x7C,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x8B,0x00,0x00,0x00,0x8C,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x8E,0x00,0x00,0x00,0x7E,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x8D,0x00,0x00,0x00,0x8E,0x00,0x00,0x00,0x39,0x00,0x07,0x00,0x06,0x00,0x00,0x00,0x8F,0x00,0x00,0x00,0x12,0x00,0x00,0x00,0x8A,0x00,0x00,0x00,0x8B,0x00,0x00,0x00,0x8D,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x90,0x00,0x00,0x00,0x4E,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x91,0x00,0x00,0x00,0x90,0x00,0x00,0x00,0x8F,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x4E,0x00,0x00,0x00,0x91,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x92,0x00,0x00,0x00,0x93,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x95,0x00,0x00,0x00,0x92,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x96,0x00,0x00,0x00,0x95,0x00,0x00,0x00,0x53,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x94,0x00,0x00,0x00,0x96,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x98,0x00,0x00,0x00,0x16,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x9A,0x00,0x00,0x00,0x98,0x00,0x00,0x00,0x99,0x00,0x00,0x00,0x85,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x9B,0x00,0x00,0x00,0x56,0x00,0x00,0x00,0x9A,0x00,0x00,0x00,0x0C,0x00,0x06,0x00,0x06,0x00,0x00,0x00,0x9C,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x9B,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x97,0x00,0x00,0x00,0x9C,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x9D,0x00,0x00,0x00,0x4A,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0x9E,0x00,0x00,0x00,0x97,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0x9F,0x00,0x00,0x00,0x9D,0x00,0x00,0x00,0x9E,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xA0,0x00,0x00,0x00,0x9F,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xA2,0x00,0x00,0x00,0x92,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xA1,0x00,0x00,0x00,0xA2,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xA4,0x00,0x00,0x00,0x94,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0xA3,0x00,0x00,0x00,0xA4,0x00,0x00,0x00,0x39,0x00,0x07,0x00,0x06,0x00,0x00,0x00,0xA5,0x00,0x00,0x00,0x12,0x00,0x00,0x00,0xA0,0x00,0x00,0x00,0xA1,0x00,0x00,0x00,0xA3,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xA6,0x00,0x00,0x00,0x4E,0x00,0x00,0x00,0x81,0x00,0x05,0x00,0x06,0x00,0x00,0x00,0xA7,0x00,0x00,0x00,0xA6,0x00,0x00,0x00,0xA5,0x00,0x00,0x00,0x3E,0x00,0x03,0x00,0x4E,0x00,0x00,0x00,0xA7,0x00,0x00,0x00,0x3D,0x00,0x04,0x00,0x06,0x00,0x00,0x00,0xA8,0x00,0x00,0x00,0x4E,0x00,0x00,0x00,0x0C,0x00,0x08,0x00,0x06,0x00,0x00,0x00,0xA9,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x2B,0x00,0x00,0x00,0xA8,0x00,0x00,0x00,0x4F,0x00,0x00,0x00,0x3C,0x00,0x00,0x00,0xFE,0x00,0x02,0x00,0xA9,0x00,0x00,0x00,0x38,0x00,0x01,0x00,];
