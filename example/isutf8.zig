//
// SPDX-License-Identifier: Apache-2.0 OR MIT
//
// Copyright (C) 2023 Shun Sakai
//

//! An example of checking whether the input is valid UTF-8.
//! The input is a file or the standard input.

const std = @import("std");

const sysexits = @import("sysexits");

pub fn main() !u8 {
    const alloc = std.heap.page_allocator;
    const args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);

    var input: []u8 = undefined;
    if (args.len < 2) {
        const stdin = std.io.getStdIn().reader();
        input = (try stdin.readUntilDelimiterOrEofAlloc(alloc, '\n', std.math.maxInt(usize))).?;
    } else {
        input = args[1];
    }

    if (std.unicode.utf8ValidateSlice(input)) {
        const stdout = std.io.getStdOut().writer();
        try stdout.print("OK\n", .{});
        return @enumToInt(sysexits.ExitCode.ok);
    } else {
        const stderr = std.io.getStdErr().writer();
        try stderr.print("Error: invalid UTF-8 sequence\n", .{});
        return @enumToInt(sysexits.ExitCode.data_err);
    }
}
