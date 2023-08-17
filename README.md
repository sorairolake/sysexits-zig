<!--
SPDX-FileCopyrightText: 2023 Shun Sakai

SPDX-License-Identifier: Apache-2.0 OR MIT
-->

# sysexits-zig

[![CI][ci-badge]][ci-url]

**sysexits-zig** is a library that provides the system exit code constants as
defined by [`<sysexits.h>`][sysexits-man-url].

This library is a port of [sysexits-rs][sysexits-rs-crate-url].

## Usage

### Example

```zig
const std = @import("std");

const sysexits = @import("sysexits");

pub fn main() !u8 {
    const bytes = [_]u8{ 0xf0, 0x9f, 0x92, 0x96 };
    if (std.unicode.utf8ValidateSlice(&bytes)) {
        try std.io.getStdOut().writer().print("{s}\n", .{bytes});
        return @enumToInt(sysexits.ExitCode.ok);
    } else {
        try std.io.getStdErr().writer().print("Error: invalid UTF-8 sequence\n", .{});
        return @enumToInt(sysexits.ExitCode.data_err);
    }
}
```

## Zig version

This library targets the latest release of Zig. This library is tested on
v0.10.1 of Zig.

## Changelog

Please see [CHANGELOG.adoc](CHANGELOG.adoc).

## Contributing

Please see [CONTRIBUTING.adoc](CONTRIBUTING.adoc).

## License

Copyright &copy; 2023 Shun Sakai (see [AUTHORS.adoc](AUTHORS.adoc))

This library is distributed under the terms of either the _Apache License 2.0_
or the _MIT License_.

See [COPYING](COPYING) for more details.

[ci-badge]: https://img.shields.io/github/actions/workflow/status/sorairolake/sysexits-zig/CI.yaml?branch=develop&label=CI&logo=github&style=for-the-badge
[ci-url]: https://github.com/sorairolake/sysexits-zig/actions?query=branch%3Adevelop+workflow%3ACI++
[sysexits-man-url]: https://man.openbsd.org/sysexits
[sysexits-rs-crate-url]: https://crates.io/crates/sysexits
