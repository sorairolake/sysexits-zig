//
// SPDX-License-Identifier: Apache-2.0 OR MIT
//
// Copyright (C) 2023 Shun Sakai
//

const std = @import("std");
const testing = std.testing;

const exit_code = @import("exit_code.zig");
pub const ExitCode = exit_code.ExitCode;

test {
    testing.refAllDeclsRecursive(@This());
}
