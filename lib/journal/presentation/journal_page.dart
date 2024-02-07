import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_button.dart';
import 'package:journal/core/theme/typography.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) => const JournalView();
}

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  final String _title = "Journal";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return CupertinoPageScaffold(
          child: JournalCupertinoSliverAppBar(
            titleLabel: _title,
            child: _JournalViewContent(),
          ),
        );
      default:
        return Scaffold(
          appBar: JournalMaterialAppBar(titleLabel: _title),
          body: Center(child: _JournalViewContent()),
        );
    }
  }
}

class _JournalViewContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello, Journal", style: satoshiRegular),
          JournalButton(
            onPressed: () {
              context.go("/journal/developer");
            },
          ),
        ],
      );
}

// class _JournalButton extends StatelessWidget {
//   const _JournalButton({super.key, required this.onPressed});
//
//   final String buttonTitle = "To developer settings";
//   final Function() onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     final TargetPlatform platform = Theme.of(context).platform;
//
//     switch (platform) {
//       case TargetPlatform.iOS:
//         return CupertinoButton(
//           onPressed: onPressed,
//           child: Text(
//             buttonTitle,
//             style: satoshiBold.copyWith(color: Colors.black),
//           ),
//         );
//       default:
//         return MaterialButton(
//           onPressed: onPressed,
//           child: Text(
//             buttonTitle,
//             style: satoshiBold.copyWith(color: Colors.black),
//           ),
//         );
//     }
//   }
// }
