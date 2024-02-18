<!--
SPDX-FileCopyrightText: 2023 Shun Sakai

SPDX-License-Identifier: Apache-2.0 OR MIT
-->

# sysexits-zig

[![CI][ci-badge]][ci-url]

**sysexits-zig** is a library that provides the system exit code constants as
defined by [`<sysexits.h>`].

This library is a port of [sysexits-rs].

## Usage

### Example

```zig
const std = @import("std");

const sysexits = @import("sysexits");

pub fn main() !u8 {
    const bytes = [_]u8{ 0xf0, 0x9f, 0x92, 0x96 };
    if (std.unicode.utf8ValidateSlice(&bytes)) {
        try std.io.getStdOut().writer().print("{s}\n", .{bytes});
        return @intFromEnum(sysexits.ExitCode.ok);
    } else {
        try std.io.getStdErr().writer().print("Error: invalid UTF-8 sequence\n", .{});
        return @intFromEnum(sysexits.ExitCode.data_err);
    }
}
```

## Zig version

This library is compatible with Zig version 0.11.0.

## Changelog

Please see [CHANGELOG.adoc].

## Contributing

Please see [CONTRIBUTING.adoc].

## License

Copyright &copy; 2023&ndash;2024 Shun Sakai (see [AUTHORS.adoc])

This library is distributed under the terms of either the _Apache License 2.0_
or the _MIT License_.

This project is compliant with version 3.0 of the [_REUSE Specification_]. See
copyright notices of individual files for more details on copyright and
licensing information.

[ci-badge]: https://img.shields.io/github/actions/workflow/status/sorairolake/sysexits-zig/CI.yaml?branch=develop&style=for-the-badge&logo=github&label=CI
[ci-url]: https://github.com/sorairolake/sysexits-zig/actions?query=branch%3Adevelop+workflow%3ACI++
[`<sysexits.h>`]: https://man.openbsd.org/sysexits
[sysexits-rs]: https://crates.io/crates/sysexits
[CHANGELOG.adoc]: CHANGELOG.adoc
[CONTRIBUTING.adoc]: CONTRIBUTING.adoc
[AUTHORS.adoc]: AUTHORS.adoc
[_REUSE Specification_]: https://reuse.software/spec/
