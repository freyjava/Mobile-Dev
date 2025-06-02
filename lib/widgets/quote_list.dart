import 'package:flutter/material.dart';
import 'quote_card.dart';

class QuoteList extends StatelessWidget {
  const QuoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) => const QuoteCard(),
        ),
        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('See more')),
      ],
    );
  }
}
