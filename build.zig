// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.addModule("sysexits", .{ .root_source_file = b.path("src/root.zig") });

    const test_step = b.step("test", "Run the tests");
    const tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_tests = b.addRunArtifact(tests);
    test_step.dependOn(&run_tests.step);

    const doc_step = b.step("doc", "Build the package documentation");
    const doc_obj = b.addObject(.{
        .name = "sysexits",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    const install_doc = b.addInstallDirectory(.{
        .source_dir = doc_obj.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "doc/sysexits",
    });
    doc_step.dependOn(&install_doc.step);

    const example_step = b.step("example", "Build examples");
    const example_names = [_][]const u8{"isutf8"};
    inline for (example_names) |example_name| {
        const example = b.addExecutable(.{
            .name = example_name,
            .root_source_file = b.path("examples/" ++ example_name ++ ".zig"),
            .target = target,
            .optimize = optimize,
        });
        example.root_module.addImport("sysexits", lib_mod);
        const install_example = b.addInstallArtifact(example, .{});
        example_step.dependOn(&example.step);
        example_step.dependOn(&install_example.step);
    }
}
