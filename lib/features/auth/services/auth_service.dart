// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
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
        token: '',
        cart: [],
      );

      http.Response response = await http.post(Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
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

      httpErrorHandle(
        context: context,
        response: response,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          await prefs.setString(
              'x-auth-token', jsonDecode(response.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void signOutUser({
    required BuildContext context,
    required email,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signout"),
        body: jsonEncode({"email": email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AuthScreen.routeName, (route) => false);
          });
    } catch (e) {
      print('Error in the signout Method');
      showSnackbar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
