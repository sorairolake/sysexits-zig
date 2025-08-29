<!--
SPDX-FileCopyrightText: 2023 Shun Sakai

SPDX-License-Identifier: CC-BY-4.0
-->

# sysexits-zig

[![CI][ci-badge]][ci-url]

**sysexits-zig** is a library that provides the system exit code constants as
defined by [`<sysexits.h>`].

This library is a port of [sysexits-rs].

## Usage

Add this package to your `build.zig.zon`:

```sh
zig fetch --save git+https://github.com/sorairolake/sysexits-zig.git
```

Add the following to your `build.zig`:

```zig
const sysexits = b.dependency("sysexits", .{});
exe.root_module.addImport("sysexits", sysexits.module("sysexits"));
```

### Documentation

See the [documentation][docs-url] for more details.

## Zig version

This library is compatible with Zig version 0.15.1.

## Source code

The upstream repository is available at
<https://github.com/sorairolake/sysexits-zig.git>.

## Changelog

Please see [CHANGELOG.adoc].

## Contributing

Please see [CONTRIBUTING.adoc].

## Similar projects

Please see <https://github.com/sorairolake/awesome-sysexits>.

## License

Copyright (C) 2023 Shun Sakai (see [AUTHORS.adoc])

This library is distributed under the terms of either the _Apache License 2.0_
or the _MIT License_.

This project is compliant with version 3.3 of the [_REUSE Specification_]. See
copyright notices of individual files for more details on copyright and
licensing information.

[ci-badge]: https://img.shields.io/github/actions/workflow/status/sorairolake/sysexits-zig/CI.yaml?branch=develop&style=for-the-badge&logo=github&label=CI
[ci-url]: https://github.com/sorairolake/sysexits-zig/actions?query=branch%3Adevelop+workflow%3ACI++
[`<sysexits.h>`]: https://man.openbsd.org/sysexits
[sysexits-rs]: https://crates.io/crates/sysexits
[docs-url]: https://sorairolake.github.io/sysexits-zig/
[CHANGELOG.adoc]: CHANGELOG.adoc
[CONTRIBUTING.adoc]: CONTRIBUTING.adoc
[AUTHORS.adoc]: AUTHORS.adoc
[_REUSE Specification_]: https://reuse.software/spec-3.3/
