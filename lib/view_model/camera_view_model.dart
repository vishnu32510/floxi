import 'dart:io';

import 'package:floxi/core/services/services.dart';
import 'package:floxi/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CameraViewModel {
  Future<void> sendImage({required File image, required BuildContext context}) async {

    // Add image file to the request
      var imageFile = await http.MultipartFile.fromPath(
        'file', // Field name used in the backend
        image.path,
        contentType: MediaType('image', 'jpeg',), // Specify the image content type
      );
    
    String url = "${AppConstants.baseUrl}/upload_receipt";
    var response = await HttpServices().postImage(
      url: url,
      imageFile: imageFile,
      body: {"username": AppConstants.username},
    );
    if (response != null && response['error'] == null) {
      // Handle successful response
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Image uploaded successfully!')));
    } else {
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to upload image.')));
      Navigator.pop(context);
    }
  }
}
