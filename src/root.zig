// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

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
//!         try std.io.getStdOut().writer().print("{s}\n", .{bytes});
//!         return @intFromEnum(sysexits.ExitCode.ok);
//!     } else {
//!         try std.io.getStdErr().writer().print("Error: invalid UTF-8 sequence\n", .{});
//!         return @intFromEnum(sysexits.ExitCode.data_err);
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
