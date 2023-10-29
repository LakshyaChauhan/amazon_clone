import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/accounts/services/account_services.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/order_details/screens/order_details.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
  }

  fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(
            child: Text('Go buy something!'),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Your Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "See all",
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetails.routeName,
                          arguments: orders![index]);
                    },
                    child: SingleProduct(
                        image: orders![index].products[0].images[0]),
                  ),
                ),
              )
            ],
          );
  }
}
