// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("sysexits", .{
        .source_file = .{ .path = "src/main.zig" },
    });

    const test_step = b.step("test", "Run library tests");
    const tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    const run_tests = b.addRunArtifact(tests);
    test_step.dependOn(&run_tests.step);

    const example_step = b.step("example", "Build examples");
    const example_names = [_][]const u8{"isutf8"};
    inline for (example_names) |example_name| {
        const example = b.addExecutable(.{
            .name = example_name,
            .root_source_file = .{ .path = "example/" ++ example_name ++ ".zig" },
            .target = target,
            .optimize = optimize,
        });
        example.addModule("sysexits", mod);
        const install_example = b.addInstallArtifact(example, .{});
        example_step.dependOn(&example.step);
        example_step.dependOn(&install_example.step);
    }
}
