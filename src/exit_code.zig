// SPDX-FileCopyrightText: 2023 Shun Sakai
//
// SPDX-License-Identifier: Apache-2.0 OR MIT

//! The system exit code constants as defined by
//! [`<sysexits.h>`](https://man.openbsd.org/sysexits).

const std = @import("std");

const testing = std.testing;

/// This type represents the system exit code constants as defined by
/// [`<sysexits.h>`](https://man.openbsd.org/sysexits).
pub const ExitCode = enum(u7) {
    /// The successful exit.
    ok,

    /// The command was used incorrectly, e.g., with the wrong number of
    /// arguments, a bad flag, bad syntax in a parameter, or whatever.
    usage = 64,

    /// The input data was incorrect in some way. This should only be used for
    /// user's data and not system files.
    data_err,

    /// An input file (not a system file) did not exist or was not readable.
    /// This could also include errors like "No message" to a mailer (if it
    /// cared to catch it).
    no_input,

    /// The user specified did not exist. This might be used for mail addresses
    /// or remote logins.
    no_user,

    /// The host specified did not exist. This is used in mail addresses or
    /// network requests.
    no_host,

    /// A service is unavailable. This can occur if a support program or file
    /// does not exist. This can also be used as a catch-all message when
    /// something you wanted to do doesn't work, but you don't know why.
    unavailable,

    /// An internal software error has been detected. This should be limited to
    /// non-operating system related errors if possible.
    software,

    /// An operating system error has been detected. This is intended to be
    /// used for such things as "cannot fork", or "cannot create pipe". It
    /// includes things like [`getuid(2)`](https://man.openbsd.org/getuid.2)
    /// returning a user that does not exist in the passwd file.
    os_err,

    /// Some system file (e.g., `/etc/passwd`, `/var/run/utmp`) does not exist,
    /// cannot be opened, or has some sort of error (e.g., syntax error).
    os_file,

    /// A (user specified) output file cannot be created.
    cant_creat,

    /// An error occurred while doing I/O on some file.
    io_err,

    /// Temporary failure, indicating something that is not really an error.
    /// For example that a mailer could not create a connection, and the
    /// request should be reattempted later.
    temp_fail,

    /// The remote system returned something that was "not possible" during a
    /// protocol exchange.
    protocol,

    /// You did not have sufficient permission to perform the operation. This
    /// is not intended for file system problems, which should use `.no_input`
    /// or `.cant_creat`, but rather for higher level permissions.
    no_perm,

    /// Something was found in an unconfigured or misconfigured state.
    config,

    const Self = @This();

    test "ExitCode to integer" {
        try testing.expect(@intFromEnum(Self.ok) == 0);
        try testing.expect(@intFromEnum(Self.usage) == 64);
        try testing.expect(@intFromEnum(Self.data_err) == 65);
        try testing.expect(@intFromEnum(Self.no_input) == 66);
        try testing.expect(@intFromEnum(Self.no_user) == 67);
        try testing.expect(@intFromEnum(Self.no_host) == 68);
        try testing.expect(@intFromEnum(Self.unavailable) == 69);
        try testing.expect(@intFromEnum(Self.software) == 70);
        try testing.expect(@intFromEnum(Self.os_err) == 71);
        try testing.expect(@intFromEnum(Self.os_file) == 72);
        try testing.expect(@intFromEnum(Self.cant_creat) == 73);
        try testing.expect(@intFromEnum(Self.io_err) == 74);
        try testing.expect(@intFromEnum(Self.temp_fail) == 75);
        try testing.expect(@intFromEnum(Self.protocol) == 76);
        try testing.expect(@intFromEnum(Self.no_perm) == 77);
        try testing.expect(@intFromEnum(Self.config) == 78);
    }

    /// The base value for `ExitCode`.
    pub const base = Self.usage;

    test "base value" {
        try testing.expect(Self.base == Self.usage);
    }

    /// The maximum value for `ExitCode`.
    pub const max = Self.config;

    test "maximum value" {
        try testing.expect(Self.max == Self.config);
    }

    /// Returns `true` if this system exit code represents successful
    /// termination.
    pub fn isSuccess(self: Self) bool {
        return self == Self.ok;
    }

    test isSuccess {
        try testing.expect(ExitCode.ok.isSuccess());
        try testing.expect(!ExitCode.usage.isSuccess());
    }

    test "isSuccess for successful termination" {
        try testing.expect(Self.ok.isSuccess());
    }

    test "isSuccess for unsuccessful termination" {
        try testing.expect(!Self.usage.isSuccess());
        try testing.expect(!Self.data_err.isSuccess());
        try testing.expect(!Self.no_input.isSuccess());
        try testing.expect(!Self.no_user.isSuccess());
        try testing.expect(!Self.no_host.isSuccess());
        try testing.expect(!Self.unavailable.isSuccess());
        try testing.expect(!Self.software.isSuccess());
        try testing.expect(!Self.os_err.isSuccess());
        try testing.expect(!Self.os_file.isSuccess());
        try testing.expect(!Self.cant_creat.isSuccess());
        try testing.expect(!Self.io_err.isSuccess());
        try testing.expect(!Self.temp_fail.isSuccess());
        try testing.expect(!Self.protocol.isSuccess());
        try testing.expect(!Self.no_perm.isSuccess());
        try testing.expect(!Self.config.isSuccess());
    }

    /// Returns `true` if this system exit code represents unsuccessful
    /// termination.
    pub fn isFailure(self: Self) bool {
        return !self.isSuccess();
    }

    test isFailure {
        try testing.expect(!ExitCode.ok.isFailure());
        try testing.expect(ExitCode.usage.isFailure());
    }

    test "isFailure for successful termination" {
        try testing.expect(!Self.ok.isFailure());
    }

    test "isFailure for unsuccessful termination" {
        try testing.expect(Self.usage.isFailure());
        try testing.expect(Self.data_err.isFailure());
        try testing.expect(Self.no_input.isFailure());
        try testing.expect(Self.no_user.isFailure());
        try testing.expect(Self.no_host.isFailure());
        try testing.expect(Self.unavailable.isFailure());
        try testing.expect(Self.software.isFailure());
        try testing.expect(Self.os_err.isFailure());
        try testing.expect(Self.os_file.isFailure());
        try testing.expect(Self.cant_creat.isFailure());
        try testing.expect(Self.io_err.isFailure());
        try testing.expect(Self.temp_fail.isFailure());
        try testing.expect(Self.protocol.isFailure());
        try testing.expect(Self.no_perm.isFailure());
        try testing.expect(Self.config.isFailure());
    }

    /// Terminates the current process with the exit code defined by `ExitCode`.
    pub fn exit(self: Self) noreturn {
        std.process.exit(@intFromEnum(self));
    }
};
