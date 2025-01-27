// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/constants/app_constant.dart';
import 'package:flutter/material.dart';

class CatergoriesListTileWidget extends StatelessWidget {
  final String title;
  final String? image;

  const CatergoriesListTileWidget({
    super.key,
    required this.title,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.network(
                // 'assets/images/categories.png',
                image ?? AppConst.noImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
