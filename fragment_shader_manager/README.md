# Fragment Shader Manager

A package for creating a helper class to manage a [FragmentShaderBuilder] in Flutter.

This package does the following:

1. Transpiles a GLSL shader into a SPIR-V binary, and generates a [Uint8List] that
   represents the SPIR-V bytes so that it can be passed into [FragmentShaderBuilder].
2. Generates a helper class for managing the shader.
  - The helper class outputs a [Shader] via [FragmentShaderBuilder].
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

## Example use cases

TODO

## How it works

The GLSL must be a subset of GLSL that the Flutter API supports. 

See https://github.com/flutter/engine/tree/master/lib/spirv for what language features are supported.

1. The GLSL file is transpiled to a SPIR-V binary via glslang.
2. The SPIR-V binary is converted to a `const` list of bytes, or [Uint8List], so that it can be passed to [FragmentShaderProgram].
3. A Dart class, or [FragmentShaderManager] is generated with references to the GLSL program and the SPIR-V bytes.
4. The class has a method on it for returning the [Shader] to be used in paint, etc.
5. The GLSL file is parsed to identify uniforms and input shaders or images, so that the [FragmentShaderManager] can update these inputs by name, and return a new shader.
6. The [FragmentProgram] and [FragmentShaderBuilder] are managed by [FragmentShaderManager] and do not need to be accessed or modified directly, but are made public in for custom use cases.
