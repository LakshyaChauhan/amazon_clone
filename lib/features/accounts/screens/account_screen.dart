import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/accounts/widgets/below_app_bar.dart';
import 'package:amazon_clone/features/accounts/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 140,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Icon(Icons.search)
                    ],
                  )),
            ],
          ),
        ),
      ),
      body:  Column(
        children: [
          const BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(text: 'Your Orders', onTap: (){})
        ],
      ),
    );
  }
}
