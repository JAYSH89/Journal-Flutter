# Journal

## Dependencies

* build_runner [link](https://pub.dev/packages/build_runner)
* equatable [link](https://pub.dev/packages/equatable)
* http [link](https://pub.dev/packages/http)
* rxDart [link](https://pub.dev/packages/rxdart)
* go_router [link](https://pub.dev/packages/go_router)
* test [link](https://pub.dev/packages/test)
* bloc_test [link](https://pub.dev/packages/bloc_test)
* mockito [link](https://pub.dev/packages/mockito)
* mappable [link](https://pub.dev/packages/dart_mappable)
* drift [link](https://pub.dev/packages/drift) [docs](https://drift.simonbinder.eu/docs/getting-started/)
* fpdart [link](https://pub.dev/packages/fpdart)

# Testing

Run tests:

```shell
flutter test
```

### Coverage

Example generating coverage report using `lcov`:

```shell
# generate `coverage/lcov.info` file
flutter test --coverage

# Generate HTML report, on MAC OS: `brew install lcov`:
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html
```
