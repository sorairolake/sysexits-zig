// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

//! The `sysexits` package provides the system exit code constants as defined
//! by [`<sysexits.h>`](https://man.openbsd.org/sysexits).

const std = @import("std");

const exit_code = @import("exit_code.zig");

const testing = std.testing;

pub const ExitCode = exit_code.ExitCode;

test {
    testing.refAllDeclsRecursive(@This());
}
