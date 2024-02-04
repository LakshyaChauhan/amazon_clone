import 'package:amazon_clone/features/accounts/widgets/account_button.dart';
import 'package:amazon_clone/features/accounts/widgets/orders.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() {
    return _TopButtonsState();
  }
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    final AuthServices authServices = AuthServices();
    final String email = Provider.of<UserProvider>(context).user.email;
    void signOut() {
      authServices.signOutUser(context: context, email: email);
    }

    return Column(
      children: [
        Row(
          children: [
            AccountButtton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButtton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButtton(
              text: 'Log Out',
              onTap: signOut,
            ),
            AccountButtton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Orders(),
      ],
    );
  }
}
