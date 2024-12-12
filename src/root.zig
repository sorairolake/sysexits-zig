// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

//! The `sysexits` package provides the system exit code constants as defined
//! by [`<sysexits.h>`](https://man.openbsd.org/sysexits).

const exit_code = @import("exit_code.zig");

pub const ExitCode = exit_code.ExitCode;

test {
    const std = @import("std");

    const testing = std.testing;

    testing.refAllDeclsRecursive(@This());
}
