// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

//! An example of checking whether the input is valid UTF-8. The input is a
//! file or the standard input.

const std = @import("std");

const sysexits = @import("sysexits");

pub fn main() !u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const input = if (args.len < 2)
        (try std.fs.File.stdin().deprecatedReader().readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize))).?
    else
        try std.fs.cwd().readFileAlloc(allocator, args[1], std.math.maxInt(usize));
    defer allocator.free(input);

    if (std.unicode.utf8ValidateSlice(input)) {
        try std.fs.File.stdout().writeAll("OK\n");
        return @intFromEnum(sysexits.ExitCode.ok);
    } else {
        try std.fs.File.stderr().writeAll("Error: invalid UTF-8 sequence\n");
        return @intFromEnum(sysexits.ExitCode.data_err);
    }
}
