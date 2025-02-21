import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadChecklistPhotosWidget extends StatefulWidget {
  final List<XFile?> images;

  const UploadChecklistPhotosWidget({
    super.key,
    required this.images,
  });

  @override
  UploadChecklistPhotosWidgetState createState() => UploadChecklistPhotosWidgetState();
}

class UploadChecklistPhotosWidgetState extends State<UploadChecklistPhotosWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Select Image Source'),
          content: const Text('Choose the source of the image.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.camera); // Return camera
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery); // Return gallery
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final XFile? pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          if (widget.images.length < 4) widget.images.add(pickedImage);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.images.length + 1,
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 4,
        //   mainAxisSpacing: 8,
        //   crossAxisSpacing: 15,
        //   childAspectRatio: 0.7,
        // ),
        itemBuilder: (context, index) {
          if (index < widget.images.length) {
            return Container(
              width: 150,
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                // fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(widget.images[index]!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.images.removeAt(index);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              width: 150,
              // padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: _pickImage,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    const Text(
                      "Add your photos",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
