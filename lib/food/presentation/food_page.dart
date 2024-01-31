import 'package:flutter/cupertino.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) => const FoodView();
}

class FoodView extends StatelessWidget {
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: Text("Hello, Food"),
  );
}
