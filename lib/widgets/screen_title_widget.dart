// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/text_utility.dart';

class ScreenTitleWidget extends StatelessWidget {
  final String title;

  const ScreenTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppText(
        text: title,
        fontsize: 34,
        fontfamily: 'Metropolis',
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
