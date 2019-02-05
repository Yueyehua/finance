# Finance
[![Build Status][travis-img]][travis-url]
[![License][license-img]][license-url]
[![Docs][docs-img]][docs-url]

This is a simple lib to apply financial formulas using Crystal-lang.

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  finance:
    github: your-github-user/finance
```
2. Run `shards install`

## Usage

```crystal
require "finance"
```

All functions are usable as is, i.e.:
```crystal
Finance::FixedRateRedeemableLoan.loan_schedule(1000, 0.02, 24)
```

## Development

WIP

## Contributing

1. Fork it (<https://github.com/Yueyehua/finance/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Richard Delaplace](https://github.com/Yueyehua) - creator and maintainer

[travis-img]: https://travis-ci.org/Yueyehua/finance.svg?branch=master
[travis-url]: https://travis-ci.org/Yueyehua/finance
[license-img]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[docs-img]: https://img.shields.io/readthedocs/finance.svg
[docs-url]: https://yueyehua.github.io/finance/
