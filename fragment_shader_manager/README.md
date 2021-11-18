# Fragment Shader Manager

A package for creating a helper class to manage a [FragmentProgram] in Flutter.

This package does the following:

1. Transpiles a GLSL shader into a SPIR-V binary, and generates a [ByteBuffer] that
   represents the SPIR-V bytes so that it can be passed into [FragmentProgram].
2. Generates a helper class for managing the shader.
  - The helper class outputs a [Shader] via [FragmentProgram].
  - The helper class has a generated method for updating the uniforms by name.
  - The helper class holds a reference to the original GLSL string and the SPIR-V.

The initial [Shader] that the helper class ouputs, and subsequent [Shader]s
that are created from updates, can be used in your Flutter app.

See the [examples](##Example-use-cases) below for more info on how to use [Shader]s.

## Setup

This package uses Bazel.

- See [Installing Bazel](https://docs.bazel.build/versions/0.18.1/install.html)

### How to use this package

TODO

cd lib
dart --no-sound-null-safety generator.dart -i test -o test  

## Example use cases

TODO

## How it works

The GLSL must be a subset of GLSL that the Flutter API supports. 

See https://github.com/flutter/engine/tree/master/lib/spirv for what language features are supported.

See https://www.khronos.org/registry/OpenGL/specs/es/3.1/GLSL_ES_Specification_3.10.withchanges.pdf
for the full spec. Section 4.3.5 specifies how unforms should be pased in

1. The GLSL file is transpiled to a SPIR-V binary via glslang.
2. The SPIR-V binary is converted to a `const` list of bytes, or [ByteBuffer], so that it can be passed to [FragmentProgram].
3. A Dart class, or [FragmentShaderManager] is generated with references to the GLSL program and the SPIR-V bytes.
4. The class has a method on it for returning the [Shader] to be used in paint, etc.
5. The GLSL file is parsed to identify uniforms and input shaders or images, so that the [FragmentShaderManager] can update these inputs by name, and return a new shader.
6. The [FragmentProgram] is managed by [FragmentShaderManager] and does need to be accessed or modified directly, but is made public in for custom use cases.

## Beyond 0.0.1

### Require only the GLSL (not spv binary)

The GLSL -> SPIR-V can be done in pub by downloading vulkan tools (glslang).

### Add SPIR-V Tools options

Similar to the method of downloading glslang above, SPIR-V Tools can be
downloaded and utilized via command line args.

### Add option for including spvasm.

Example:

```
  /// Direct access to the SPIR-V Assembly string.
  /// 
  /// In general, this is not needed, but may be useful for debugging or edge cases.
  String get spvasm => _spvasmString;

  const _spvasmString = {{_spvasmString}};
```