//
// SPDX-License-Identifier: Apache-2.0 OR MIT
//
// Copyright (C) 2023 Shun Sakai
//

const std = @import("std");

const sysexits = @import("sysexits");

pub fn main() u8 {
    const alloc = std.heap.page_allocator;
    const args = std.process.argsAlloc(alloc) catch |err| {
        std.debug.panic("{}\n", .{err});
    };
    defer std.process.argsFree(alloc, args);

    if (std.unicode.utf8ValidateSlice(args[1])) {
        std.debug.print("OK\n", .{});
        return @enumToInt(sysexits.ExitCode.ok);
    } else {
        std.debug.print("Error: invalid UTF-8 sequence\n", .{});
        return @enumToInt(sysexits.ExitCode.data_err);
    }
}
