import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/widgets/profile/change_password_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_spaces.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_utility.dart';
import '../../../widgets/screen_title_widget.dart';

class RatingReviewScreen extends StatelessWidget {
  const RatingReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Rating and Reivews'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTitleWidget(title: 'Rating&Reivews'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appSpaces.spaceForHeight10,
                const AppText(text: '8 Reviews'),
                appSpaces.spaceForHeight10,
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            child: AppText(
                              text: 'HM',
                              textColor: Colors.white,
                            ),
                          ),
                          appSpaces.spaceForWidth10,
                          const AppText(
                            text: 'Helena moore',
                            fontsize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < 4 ? Icons.star : Icons.star_outline,
                              color: index < 4 ? AppColor.startYellow : Colors.grey,
                              size: 16,
                            );
                          }),
                          const Spacer(),
                          const AppText(
                            text: 'June 5, 2019',
                            fontsize: 12,
                            textColor: Colors.grey,
                          ),
                        ],
                      ),
                      appSpaces.spaceForHeight10,
                      const AppText(
                        text:
                            'This dress is great! Very classy and comfortable. It fit perfectly. alskjdfl kajs dlkfj laksjd flkj kaj sdflkjiasud nfiasdhuf jaskldfj lkasj dflkajs dlkfjuia;; snk',
                        fontsize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          renderBottomSheet(
            context,
            Column(
              children: [
                const AppText(text: 'What is you rate?'),
                const AppText(
                  text: 'Please share your opinion about the product',
                ),
                // customField(),
                CustomButton(
                  text: 'Send Review',
                  onPressed: () {},
                )
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          width: 140,
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit,
                size: 14,
                color: Colors.white,
              ),
              appSpaces.spaceForWidth10,
              const AppText(
                text: 'Write a review',
                fontsize: 13,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
