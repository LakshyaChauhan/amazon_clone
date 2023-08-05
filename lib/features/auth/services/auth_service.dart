import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  void signUpUser({
    required BuildContext context,
    required name,
    required email,
    required password,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response response = await http.post(Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(
              context,
              "Account created! Login with the same credentials!",
            );
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required email,
    required password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      print(response.body);
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            preferences.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
