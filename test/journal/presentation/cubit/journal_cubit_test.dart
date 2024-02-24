import 'package:bloc_test/bloc_test.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:journal/journal/presentation/cubit/journal_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockJournalRepository repository;
  late JournalCubit journalCubit;
  late JournalEntry testEntry;

  setUp(() {
    repository = MockJournalRepository();
    journalCubit = JournalCubit(repository);
    testEntry = JournalEntry(
      id: 1,
      food: Food(
        id: 1,
        name: 'Potato',
        carbs: 23.2,
        proteins: 3.1,
        fats: 0.1,
        amount: 1,
        foodUnit: FoodUnit.gram,
      ),
      date: DateTime.parse("2024-01-31T17:23:02Z"),
      amount: 1.0,
    );
  });

  tearDown(() {
    journalCubit.close();
  });

  group("getJournalEntries()", () {
    blocTest<JournalCubit, JournalState>(
      "should emit list of entries successful",
      build: () {
        when(repository.getAll()).thenAnswer((_) async => [testEntry]);
        return journalCubit;
      },
      act: (cubit) async => cubit.getJournalEntries(),
      expect: () => [
        JournalState(entries: [testEntry]),
      ],
    );
  });
}
