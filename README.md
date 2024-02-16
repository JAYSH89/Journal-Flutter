# Journal

## Dependencies

* build_runner [link](https://pub.dev/packages/build_runner)
* equatable [link](https://pub.dev/packages/equatable)
* http [link](https://pub.dev/packages/http)
* rxDart [link](https://pub.dev/packages/rxdart)
* isar [link](https://pub.dev/packages/isar)
* go_router [link](https://pub.dev/packages/go_router)
* test [link](https://pub.dev/packages/test)
* bloc_test [link](https://pub.dev/packages/bloc_test)
* mockito [link](https://pub.dev/packages/mockito)
* mappable [link](https://pub.dev/packages/dart_mappable)
* fpdart [link](https://pub.dev/packages/fpdart)
* shared_preferences [link](https://pub.dev/packages/shared_preferences)
* uuid [link](https://pub.dev/packages/uuid)
* freezed [link](https://pub.dev/packages/freezed)
* freezed_annotation [link](https://pub.dev/packages/freezed_annotation)
* very_good_analysis [link](https://pub.dev/packages/very_good_analysis)

## Testing

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

## Build runner

```shell
dart run build_runner build
```

```shell
dart run build_runner watch
```

```shell
dart run build_runner build --delete-conflicting-outputs
```
