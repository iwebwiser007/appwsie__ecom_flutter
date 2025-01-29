import 'package:flutter/material.dart';

import '../utils/text_utility.dart';

class NoDataFoundWidget extends StatelessWidget {
  final Color backgroundColor;

  const NoDataFoundWidget({
    super.key,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        color: backgroundColor,
        child: const AppText(
          text: 'No Data Found!',
        ),
      ),
    );
  }
}
