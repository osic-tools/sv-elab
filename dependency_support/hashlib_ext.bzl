load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")

def _vendored_hashlib_extension_impl(ctx):
    # Resolve third_party/hashlib relative to this module's root rather than
    # the consumer's, so the extension also works when sv-elab is consumed as
    # a bazel_dep with local_path_override.
    module_root = ctx.path(Label("//:MODULE.bazel")).dirname
    new_local_repository(
        name = "vendored-hashlib",
        path = str(module_root.get_child("third_party/hashlib")),
        build_file = "//:dependency_support/hashlib.BUILD.bazel",
    )

vendored_hashlib = module_extension(
    implementation = _vendored_hashlib_extension_impl,
)
