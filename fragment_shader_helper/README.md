# Flutter Fragment Shader Helper

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

## Generating a helper class from GLSL

TODO

## Example use cases

TODO