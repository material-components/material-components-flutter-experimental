"""Build rules for transpiling GLSL to and from other shader formats"""



def glsl_to_spv(name, glsl_src, shadercopts = []):
    """Compiles a given GLSL source file to a SPIR-V binary using glslc.

    Args:
      name: A unique name for this rule. The output binary is name + ".spv".
      glsl_src: A GLSL source file.
      shadercopts: Additional arguments to be passed to glslc.
    """
    print(name)
    print(glsl_src)

    # cmd = '$(location //third_party/shaderc/glslc) -I . -o "$(OUTS)"'

    # cmd += " " + " ".join(shadercopts)
    # cmd += " $(location %s)" % glsl_src
    # native.genrule(
    #     name = name,
    #     srcs = [glsl_src],
    #     outs = [name + '.spv'],
    #     exec_tools = ["//third_party/shaderc/glslc"],
    #     cmd = cmd,
    # )


# def spv_to_spvasm(name, spv):
#     """Compiles a given SPIR-V binary file to a SPIR-V Assembly file using spirv-dis.

#     Args:
#       name: A unique name for this rule. The output binary is name + ".spvasm".
#       spv: A SPIR-V binary file.
#     """
#     cmd = "$(location //third_party/spirv_tools:spirv-dis)"

#     cmd += " $(location %s)" % spv
#     cmd += " -o $(OUTS)"
#     native.genrule(
#         name = name,
#         srcs = [spv],
#         outs = [name + ".spvasm"],
#         exec_tools = ["//third_party/spirv_tools:spirv-dis"],
#         cmd = cmd,
#     )

# def glsl_to_webgl1(name, glsl_src, shadercopts = []):
#     """Transpiles GLSL of any version to WebGL1-compatible GLSL.

#     Args:
#       name: A unique name for this rule. The output binary is name + ".glsl".
#       glsl_src: A GLSL source file.
#       shadercopts: Additional arguments to be passed to glslc.
#     """

#     spirv_name = "%s__spirv" % name

#     glsl_to_spv(
#         name = spirv_name,
#         glsl_src = glsl_src,
#         shadercopts = shadercopts,
#     )

#     cmd = '$(location //third_party/spirv_cross) --version 100 --es $(location {}) --output "$(OUTS)"'.format(spirv_name)

#     native.genrule(
#         name = name,
#         srcs = [spirv_name],
#         outs = [name + ".glsl"],
#         exec_tools = ["//third_party/spirv_cross"],
#         cmd = cmd,
#         visibility = visibility,
#     )

# def spirv_opt(name, spirv_src, opts = []):
#     """Runs spirv_tools optimizer on a SPIR-V binary to create a new optimized SPIR-V binary.

#     Args:
#       name: A unique name for this rule. The output binary is name + ".spv".
#       spirv_src: A SPIR-V source file.
#       opts: Additional arguments to be passed to the optimizer.
#     """
#     cmd = "$(location //third_party/spirv_tools:spirv-opt)"

#     cmd += " " + " ".join(opts)
#     cmd += " $(location %s)" % spirv_src
#     cmd += " -o $(OUTS)"
#     native.genrule(
#         name = name,
#         srcs = [spirv_src],
#         outs = [name + ".spv"],
#         exec_tools = ["//third_party/spirv_tools:spirv-opt"],
#         cmd = cmd,
#     )