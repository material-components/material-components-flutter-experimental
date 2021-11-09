# load("//dart:build_defs.bzl", "dart_vm_binary")
load("helper.bzl", "glsl_to_spv", "spirv_opt", "spv_to_spvasm")

package(default_visibility = ["//visibility:public"])

######################################
# Fragment Shader Helper for Flutter #
######################################

glsl_to_spv(
    name = "fragment_shader_helper_spirv",
    glsl_src = "test/test.glsl",
    shadercopts = [
        "-fshader-stage=fragment",
        "--target-env=opengl",
    ],
)

spirv_opt(
    name = "ripple_fragment_shader_spirv_opt",
    opts = [
        "--loop-unroll",
        "--if-conversion",
    ],
    spirv_src = "ripple_fragment_shader_spirv",
)

# unoptimized spavsm for debugging

spv_to_spvasm(
    name = "ripple_fragment_shader_spirv_spvasm",
    spv = "ripple_fragment_shader_spirv",
)

# optimzized spavsm for debugging

spv_to_spvasm(
    name = "ripple_fragment_shader_spirv_opt_spvasm",
    spv = "ripple_fragment_shader_spirv_opt",
)

dart_vm_binary(
    name = "flutter_ripple_spirv_generator",
    data = [":ripple_fragment_shader_spirv_opt"],
    script_file = "gen/src/ripple_spirv_generator.dart",
    deps = [
        "//third_party/dart/args",
        "//third_party/dart/logging",
    ],
)

genrule(
    name = "generate_flutter_ripple_source",
    srcs = [":ripple_fragment_shader_spirv_opt"],
    outs = ["m3_ripple.g.dart"],
    cmd = '$(location :flutter_ripple_spirv_generator) -i $(location :ripple_fragment_shader_spirv_opt) -o "$(OUTS)"',
    exec_tools = [":flutter_ripple_spirv_generator"],
    executable = True,
    message = "Generating spirv source for flutter M3 ripple...",
)

########
# Test #
########

glsl_to_spv(
    name = "test_sparkle_ripple_spv",
    glsl_src = ":test_sparkle_ripple_glsl",
    shadercopts = [
        "-fshader-stage=fragment",
        "--target-env=opengl",
    ],
)

spirv_opt(
    name = "test_sparkle_ripple_spv_opt",
    opts = [
        "--loop-unroll",
        "--if-conversion",
    ],
    spirv_src = "test_sparkle_ripple_spv",
)

dart_vm_binary(
    name = "test_sparkle_flutter_ripple_spirv_generator",
    data = [":test_sparkle_ripple_spv_opt"],
    script_file = "gen/src/ripple_spirv_generator.dart",
    deps = [
        "//third_party/dart/args",
        "//third_party/dart/logging",
    ],
)

genrule(
    name = "test_sparkle_generate_flutter_ripple_source",
    srcs = [":test_sparkle_ripple_spv_opt"],
    outs = ["test_sparkle_ripple.g.dart"],
    cmd = '$(location :test_sparkle_flutter_ripple_spirv_generator) -i $(location :test_sparkle_ripple_spv_opt) -o "$(OUTS)"',
    exec_tools = [":test_sparkle_flutter_ripple_spirv_generator"],
    executable = True,
    message = "Generating spirv source for test sparkle flutter ripple...",
)