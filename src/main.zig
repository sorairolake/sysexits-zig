//
// SPDX-License-Identifier: Apache-2.0 OR MIT
//
// Copyright (C) 2023 Shun Sakai
//

//! The `sysexits` package provides the system exit code constants as defined
//! by `<sysexits.h>`.
//!
//! # Examples
//!
//! ## Returns the exit code as defined by <sysexits.h>
//!
//! ```
//! const std = @import("std");
//!
//! const sysexits = @import("sysexits");
//!
//! pub fn main() !u8 {
//!     const bytes = [_]u8{ 0xf0, 0x9f, 0x92, 0x96 };
//!     if (std.unicode.utf8ValidateSlice(&bytes)) {
//!         const stdout = std.io.getStdOut().writer();
//!         try stdout.print("{s}\n", .{bytes});
//!         return @enumToInt(sysexits.ExitCode.ok);
//!     } else {
//!         const stderr = std.io.getStdErr().writer();
//!         try stderr.print("Error: invalid UTF-8 sequence\n", .{});
//!         return @enumToInt(sysexits.ExitCode.data_err);
//!     }
//! }
//! ```

const std = @import("std");

const exit_code = @import("exit_code.zig");

const testing = std.testing;

pub const ExitCode = exit_code.ExitCode;

test {
    testing.refAllDeclsRecursive(@This());
}
