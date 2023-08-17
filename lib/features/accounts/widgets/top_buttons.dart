import 'package:amazon_clone/features/accounts/widgets/account_button.dart';
import 'package:amazon_clone/features/accounts/widgets/orders.dart';
import 'package:flutter/material.dart';

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
              onTap: () {},
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
