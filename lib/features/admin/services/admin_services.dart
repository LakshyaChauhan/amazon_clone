// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      
      final cloudinary = CloudinaryPublic('djd3gm4qy', 'd2arz1xa');

      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.user.token,
          }, 
          body: product.toJson(),
          );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Product added successfully.');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
