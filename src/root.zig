// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

//! The `sysexits` package provides the system exit code constants as defined
//! by [`<sysexits.h>`].
//!
//! [`<sysexits.h>`]: https://man.openbsd.org/sysexits

pub const ExitCode = @import("exit_code.zig").ExitCode;

test {
    const testing = @import("std").testing;

    testing.refAllDeclsRecursive(@This());
}
