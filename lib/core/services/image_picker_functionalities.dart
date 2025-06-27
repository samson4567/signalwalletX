import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerFunctionalities {
  final BuildContext context;
  ImagePickerFunctionalities(this.context);

  final picker = ImagePicker();
  File? image;
  //Image Picker function to get image from gallery
  Future<File?> getImageFromGallery() async {
    //  You need package:image_picker/image_picker.dart
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      // widget.getImageFile.call(_image!);
    }
    return image;
  }

  //Image Picker function to get image from camera
  Future<File?> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    return image;
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    await showCupertinoModalPopup<bool>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () async {
              // get image from gallery
              await getImageFromGallery();
              // close the options modal
              Navigator.of(context).pop();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              // get image from camera
              await getImageFromCamera();
              // close the options modal
              Navigator.of(context).pop();
            },
          ),
          // CupertinoActionSheetAction(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //       _deleteImage();
          //     },
          //     child: const Text(
          //       'Delete Image',
          //       style: TextStyle(color: Colors.red),
          //     ))
        ],
      ),
    );
  }
}
