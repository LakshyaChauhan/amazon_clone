import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());

    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());

    case SearchScreen.routeName:
      var searchQuerry = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuerry: searchQuerry,
              ));

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));

    case AdressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => AdressScreen(
                totalAmount: totalAmount,
              ));

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not  exist'),
                ),
              ));
  }
}
