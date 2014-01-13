# Filegen (Developer Readme)

## Utilities

* Code coverage: simplecov
* Code quality: rubocop
* Documentation: yard
* Tasks: rake
* Testing: rspec, cucumber + aruba
* Testing-Helper: fedux_org-stdlib

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write your tests
4. Commit your changes (`git commit -am 'Add some tests for feature'`)
5. Write your code
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Make sure all tests pass (`bundle exec rspec && bundle exec cucumber`)
8. Make sure rubocop does not find any offences (`rubocop`) 
9. Push to the branch (`git push origin my-new-feature`)
10. Create new Pull Request
11. Make sure all tests pass on travis

Commits must not...
* change the version-number
* contain rubocop:disable-comments
