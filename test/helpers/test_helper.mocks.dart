// Mocks generated by Mockito 5.4.4 from annotations
// in journal/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:journal/food/data/datasource/food_data_source.dart' as _i4;
import 'package:journal/food/data/local/food_entity.dart' as _i6;
import 'package:journal/food/domain/models/food.dart' as _i15;
import 'package:journal/food/domain/repository/food_repository.dart' as _i14;
import 'package:journal/journal/data/datasource/journal_data_source.dart'
    as _i7;
import 'package:journal/journal/data/local/journal_entry_entity.dart' as _i8;
import 'package:journal/journal/domain/models/journal_entry.dart' as _i12;
import 'package:journal/journal/domain/repository/journal_repository.dart'
    as _i11;
import 'package:journal/profile/data/datasource/user_details_data_source.dart'
    as _i9;
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart'
    as _i10;
import 'package:journal/profile/domain/models/user_detail.dart' as _i2;
import 'package:journal/profile/domain/models/weight_measurement.dart' as _i3;
import 'package:journal/profile/domain/repository/profile_repository.dart'
    as _i13;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserDetail_0 extends _i1.SmartFake implements _i2.UserDetail {
  _FakeUserDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeightMeasurement_1 extends _i1.SmartFake
    implements _i3.WeightMeasurement {
  _FakeWeightMeasurement_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FoodDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockFoodDataSource extends _i1.Mock implements _i4.FoodDataSource {
  MockFoodDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Stream<List<_i6.FoodEntity>> watchAll() => (super.noSuchMethod(
        Invocation.method(
          #watchAll,
          [],
        ),
        returnValue: _i5.Stream<List<_i6.FoodEntity>>.empty(),
      ) as _i5.Stream<List<_i6.FoodEntity>>);

  @override
  _i5.Future<List<_i6.FoodEntity>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i5.Future<List<_i6.FoodEntity>>.value(<_i6.FoodEntity>[]),
      ) as _i5.Future<List<_i6.FoodEntity>>);

  @override
  _i5.Future<_i6.FoodEntity?> getFoodById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getFoodById,
          [id],
        ),
        returnValue: _i5.Future<_i6.FoodEntity?>.value(),
      ) as _i5.Future<_i6.FoodEntity?>);

  @override
  _i5.Future<List<_i6.FoodEntity>> searchFoodByName(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchFoodByName,
          [name],
        ),
        returnValue: _i5.Future<List<_i6.FoodEntity>>.value(<_i6.FoodEntity>[]),
      ) as _i5.Future<List<_i6.FoodEntity>>);

  @override
  _i5.Future<_i6.FoodEntity?> saveFood(_i6.FoodEntity? food) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFood,
          [food],
        ),
        returnValue: _i5.Future<_i6.FoodEntity?>.value(),
      ) as _i5.Future<_i6.FoodEntity?>);

  @override
  _i5.Future<bool> deleteFood(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteFood,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [JournalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJournalDataSource extends _i1.Mock implements _i7.JournalDataSource {
  MockJournalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i8.JournalEntryEntity>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i5.Future<List<_i8.JournalEntryEntity>>.value(
            <_i8.JournalEntryEntity>[]),
      ) as _i5.Future<List<_i8.JournalEntryEntity>>);

  @override
  _i5.Future<_i8.JournalEntryEntity?> getById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getById,
          [id],
        ),
        returnValue: _i5.Future<_i8.JournalEntryEntity?>.value(),
      ) as _i5.Future<_i8.JournalEntryEntity?>);

  @override
  _i5.Future<List<_i8.JournalEntryEntity>> getBetween(
    DateTime? start,
    DateTime? end,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBetween,
          [
            start,
            end,
          ],
        ),
        returnValue: _i5.Future<List<_i8.JournalEntryEntity>>.value(
            <_i8.JournalEntryEntity>[]),
      ) as _i5.Future<List<_i8.JournalEntryEntity>>);

  @override
  _i5.Future<_i8.JournalEntryEntity?> save(
          _i8.JournalEntryEntity? journalEntry) =>
      (super.noSuchMethod(
        Invocation.method(
          #save,
          [journalEntry],
        ),
        returnValue: _i5.Future<_i8.JournalEntryEntity?>.value(),
      ) as _i5.Future<_i8.JournalEntryEntity?>);

  @override
  _i5.Future<bool> delete(int? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [UserDetailsDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserDetailsDataSource extends _i1.Mock
    implements _i9.UserDetailsDataSource {
  MockUserDetailsDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserDetail getUserDetail() => (super.noSuchMethod(
        Invocation.method(
          #getUserDetail,
          [],
        ),
        returnValue: _FakeUserDetail_0(
          this,
          Invocation.method(
            #getUserDetail,
            [],
          ),
        ),
      ) as _i2.UserDetail);

  @override
  _i5.Future<_i2.UserDetail> saveUserDetail(_i2.UserDetail? userDetail) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveUserDetail,
          [userDetail],
        ),
        returnValue: _i5.Future<_i2.UserDetail>.value(_FakeUserDetail_0(
          this,
          Invocation.method(
            #saveUserDetail,
            [userDetail],
          ),
        )),
      ) as _i5.Future<_i2.UserDetail>);
}

/// A class which mocks [WeightMeasurementDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeightMeasurementDataSource extends _i1.Mock
    implements _i10.WeightMeasurementDataSource {
  MockWeightMeasurementDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.WeightMeasurement> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: <_i3.WeightMeasurement>[],
      ) as List<_i3.WeightMeasurement>);

  @override
  _i3.WeightMeasurement save(_i3.WeightMeasurement? measurement) =>
      (super.noSuchMethod(
        Invocation.method(
          #save,
          [measurement],
        ),
        returnValue: _FakeWeightMeasurement_1(
          this,
          Invocation.method(
            #save,
            [measurement],
          ),
        ),
      ) as _i3.WeightMeasurement);

  @override
  dynamic delete(String? id) => super.noSuchMethod(Invocation.method(
        #delete,
        [id],
      ));
}

/// A class which mocks [JournalRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockJournalRepository extends _i1.Mock implements _i11.JournalRepository {
  MockJournalRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i12.JournalEntry>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue:
            _i5.Future<List<_i12.JournalEntry>>.value(<_i12.JournalEntry>[]),
      ) as _i5.Future<List<_i12.JournalEntry>>);

  @override
  _i5.Future<_i12.JournalEntry?> getById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getById,
          [id],
        ),
        returnValue: _i5.Future<_i12.JournalEntry?>.value(),
      ) as _i5.Future<_i12.JournalEntry?>);

  @override
  _i5.Future<List<_i12.JournalEntry>> getBetween(
    DateTime? lower,
    DateTime? upper,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBetween,
          [
            lower,
            upper,
          ],
        ),
        returnValue:
            _i5.Future<List<_i12.JournalEntry>>.value(<_i12.JournalEntry>[]),
      ) as _i5.Future<List<_i12.JournalEntry>>);

  @override
  _i5.Future<_i12.JournalEntry?> save(_i12.JournalEntry? entry) =>
      (super.noSuchMethod(
        Invocation.method(
          #save,
          [entry],
        ),
        returnValue: _i5.Future<_i12.JournalEntry?>.value(),
      ) as _i5.Future<_i12.JournalEntry?>);

  @override
  _i5.Future<bool> delete(int? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [ProfileRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileRepository extends _i1.Mock implements _i13.ProfileRepository {
  MockProfileRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserDetail getUserDetails() => (super.noSuchMethod(
        Invocation.method(
          #getUserDetails,
          [],
        ),
        returnValue: _FakeUserDetail_0(
          this,
          Invocation.method(
            #getUserDetails,
            [],
          ),
        ),
      ) as _i2.UserDetail);

  @override
  _i5.Future<_i2.UserDetail> saveUserDetails(_i2.UserDetail? profile) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveUserDetails,
          [profile],
        ),
        returnValue: _i5.Future<_i2.UserDetail>.value(_FakeUserDetail_0(
          this,
          Invocation.method(
            #saveUserDetails,
            [profile],
          ),
        )),
      ) as _i5.Future<_i2.UserDetail>);

  @override
  List<_i3.WeightMeasurement> getAllWeightMeasurements() => (super.noSuchMethod(
        Invocation.method(
          #getAllWeightMeasurements,
          [],
        ),
        returnValue: <_i3.WeightMeasurement>[],
      ) as List<_i3.WeightMeasurement>);

  @override
  _i3.WeightMeasurement saveWeightMeasurement(
          _i3.WeightMeasurement? measurement) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWeightMeasurement,
          [measurement],
        ),
        returnValue: _FakeWeightMeasurement_1(
          this,
          Invocation.method(
            #saveWeightMeasurement,
            [measurement],
          ),
        ),
      ) as _i3.WeightMeasurement);

  @override
  dynamic deleteWeightMeasurement(String? id) =>
      super.noSuchMethod(Invocation.method(
        #deleteWeightMeasurement,
        [id],
      ));
}

/// A class which mocks [FoodRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFoodRepository extends _i1.Mock implements _i14.FoodRepository {
  MockFoodRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Stream<List<_i15.Food>> watchAll() => (super.noSuchMethod(
        Invocation.method(
          #watchAll,
          [],
        ),
        returnValue: _i5.Stream<List<_i15.Food>>.empty(),
      ) as _i5.Stream<List<_i15.Food>>);

  @override
  _i5.Future<List<_i15.Food>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i5.Future<List<_i15.Food>>.value(<_i15.Food>[]),
      ) as _i5.Future<List<_i15.Food>>);

  @override
  _i5.Future<_i15.Food?> getFoodById({required int? id}) => (super.noSuchMethod(
        Invocation.method(
          #getFoodById,
          [],
          {#id: id},
        ),
        returnValue: _i5.Future<_i15.Food?>.value(),
      ) as _i5.Future<_i15.Food?>);

  @override
  _i5.Future<List<_i15.Food>> searchFoodByName({required String? name}) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchFoodByName,
          [],
          {#name: name},
        ),
        returnValue: _i5.Future<List<_i15.Food>>.value(<_i15.Food>[]),
      ) as _i5.Future<List<_i15.Food>>);

  @override
  _i5.Future<_i15.Food?> saveFood(_i15.Food? food) => (super.noSuchMethod(
        Invocation.method(
          #saveFood,
          [food],
        ),
        returnValue: _i5.Future<_i15.Food?>.value(),
      ) as _i5.Future<_i15.Food?>);

  @override
  _i5.Future<bool> deleteFood({required int? id}) => (super.noSuchMethod(
        Invocation.method(
          #deleteFood,
          [],
          {#id: id},
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
