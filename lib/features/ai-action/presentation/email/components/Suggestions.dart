import 'package:code/features/ai-action/presentation/email/suggestions/Suggestion.dart';
import 'package:flutter/material.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  static const List<Widget> suggestions = [
    Suggestion(icon: 'assets/icons/thanks.png', label: 'Thanks'),
    Suggestion(icon: 'assets/icons/sorry.png', label: 'Sorry'),
    Suggestion(icon: 'assets/icons/like.png', label: 'Yes'),
    Suggestion(icon: 'assets/icons/dislike.png', label: 'No'),
    Suggestion(icon: 'assets/icons/followup.png', label: 'Follow up'),
    Suggestion(icon: 'assets/icons/confused.png', label: 'Request for more information'),
  ];

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 0,
      children: suggestions,
    );
  }
}
