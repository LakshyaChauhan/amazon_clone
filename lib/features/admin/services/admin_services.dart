import 'dart:io';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async{
    try {
      
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}