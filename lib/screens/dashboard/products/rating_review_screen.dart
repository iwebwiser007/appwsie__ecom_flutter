// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/screens/dashboard/products/upload_rating_images.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';

import 'package:appwise_ecom/widgets/profile/change_password_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_constant.dart';
import '../../../customs/custom_field.dart';
import '../../../models/product_details_model.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/app_spaces.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/text_utility.dart';
import '../../../widgets/screen_title_widget.dart';

class RatingReviewScreen extends ConsumerStatefulWidget {
  final ProductDetailsModel productData;
  final List<Ratings> ratings;

  const RatingReviewScreen({
    super.key,
    required this.productData,
    required this.ratings,
  });

  @override
  ConsumerState<RatingReviewScreen> createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends ConsumerState<RatingReviewScreen> {
  final List<XFile> ratingImagesToUpload = [];
  final TextEditingController reviewController = TextEditingController();
  int _currentRating = 0;

  void uploadChecklistImagesFunc() async {
    final userId = ref.read(userDataProvider)?.id;
    try {
      setLoader(ref, true);

      Map<String, dynamic> imageMap = {
        // "images": ratingImagesToUpload.first.path,
      };

      for (var photo in ratingImagesToUpload) {
        imageMap.addAll({
          'images': photo.path,
        });
      }

      print(imageMap);

      final Map<String, dynamic> body = {
        "user_id": userId,
        "product_id": widget.productData.id.toString(),
        "review": reviewController.text.trim(),
        "rating": _currentRating,
        "status": 1,
        // "images": imageMap['images'],
      };

      ApiResponse response = await RequestUtils().formDataPostRequest(
        url: ServiceUrl.addRatingUrl,
        fields: body,
        imageMap: imageMap,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        context.pop();
      }

      Utils.snackBar(response.message.toString(), context, duration: 1);
      setLoader(ref, false);
    } catch (e) {
      setLoader(ref, false);
      AppConst.showConsoleLog(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Rating and Reivews'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitleWidget(title: 'Rating&Reivews'),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appSpaces.spaceForHeight10,
                  AppText(text: '${widget.ratings.length} Reviews'),
                  appSpaces.spaceForHeight10,
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.ratings.length,
                    itemBuilder: (ctx, index) {
                      final rating = widget.ratings[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: AppText(
                                    text: getInitials(safeString(rating.name)),
                                    textColor: Colors.white,
                                  ),
                                ),
                                appSpaces.spaceForWidth10,
                                AppText(
                                  text: safeString(rating.name).capitalizeFirstLetter(),
                                  fontsize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (rating.rating != null)
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      index < rating.rating! ? Icons.star : Icons.star_outline,
                                      color: index < rating.rating! ? AppColor.startYellow : Colors.grey,
                                      size: 16,
                                    );
                                  }),
                                  const Spacer(),
                                  AppText(
                                    text: rating.createdAt!,
                                    fontsize: 12,
                                    textColor: Colors.grey,
                                  ),
                                ],
                              ),
                            appSpaces.spaceForHeight10,
                            AppText(
                              text: rating.review!,
                              fontsize: 14,
                              height: 1.4,
                              fontWeight: FontWeight.w200,
                            ),
                            appSpaces.spaceForHeight10,
                            if (rating.images != null && rating.images!.isNotEmpty)
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: rating.images?.length,
                                  itemBuilder: (ctx, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Container(
                                        // width: 100,
                                        margin: const EdgeInsets.all(6),
                                        child: CachedNetworkImage(
                                          imageUrl: rating.images?[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          renderBottomSheet(
            context,
            StatefulBuilder(
              builder: (context, setstate) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const AppText(
                          textAlign: TextAlign.center,
                          text: 'What is your rate?',
                          fontsize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _currentRating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 35,
                              ),
                              onPressed: () {
                                setstate(() {
                                  _currentRating = index + 1;
                                });
                                // widget.onRatingChanged(_currentRating);
                              },
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const AppText(
                          textAlign: TextAlign.center,
                          text: 'Please share your opinion about the product',
                          fontWeight: FontWeight.w600,
                          fontsize: 20,
                        ),
                        customField(
                          controller: reviewController,
                          hintText: 'Your review',
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        UploadChecklistPhotosWidget(
                          images: ratingImagesToUpload,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: 'Send Review',
                          onPressed: () {
                            uploadChecklistImagesFunc();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
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
