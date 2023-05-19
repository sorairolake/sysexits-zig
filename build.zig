//
// SPDX-License-Identifier: Apache-2.0 OR MIT
//
// Copyright (C) 2023 Shun Sakai
//

const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("sysexits", "src/main.zig");
    lib.setBuildMode(mode);
    lib.install();

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);

    const example_step = b.step("example", "Build examples");

    const example_names = [_][]const u8{"isutf8"};
    for (example_names) |example_name| {
        const example = b.addExecutable(example_name, b.fmt("example/{s}.zig", .{example_name}));
        example.addPackagePath("sysexits", "src/main.zig");
        example.setBuildMode(mode);
        example.install();

        example_step.dependOn(&example.step);
    }
}
