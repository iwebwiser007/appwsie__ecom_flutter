import 'package:appwise_ecom/constants/app_constant.dart';
import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double width;
  final double height;
  final bool issmallSize;

  const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = 200,
    this.issmallSize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey.withOpacity(0.3),
        child: Center(
          child: CachedNetworkImage(imageUrl: AppConst.noImg),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fit,
      width: width,
      // memCacheWidth: 45,
      // memCacheHeight: 60,
      // maxHeightDiskCache: 60,
      // maxWidthDiskCache: 45,
      height: height,
      placeholder: (context, url) => Center(
        child: issmallSize ? Container(color: Colors.grey.withOpacity(0.3)) : const Loader(),
      ),
      // errorWidget: (context, url, error) => const Center(
      //   child: Icon(Icons.error),
      // ),
      errorWidget: (context, url, error) {
        return const Icon(Icons.error);
      },
    );
  }
}
