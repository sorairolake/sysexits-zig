#
# SPDX-License-Identifier: Apache-2.0 OR MIT
#
# Copyright (C) 2023 Shun Sakai
#

alias all := default

# Run default recipe
default: build

# Build a project
@build:
    zig build

# Run tests
@test:
    zig build test

# Run the formatter
@fmt:
    zig fmt .

# Run the linter for GitHub Actions workflow files
@lint-github-actions:
    actionlint

# Run the formatter for the README
@fmt-readme:
    npx prettier -w README.md

# Increment the version
@bump part:
    bump2version {{part}}
