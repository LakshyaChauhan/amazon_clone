import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/features/address/services/payment_configurations.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AdressScreen extends StatefulWidget {
  static const String routeName = '/address';

  const AdressScreen({super.key, required this.totalAmount});
  final String totalAmount;

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final AdressServices adressServices = AdressServices();

  List<PaymentItem> paymentItems = [];
  String os = Platform.operatingSystem;

  String addressToBeUsed = "";

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text.isNotEmpty} , ${areaController.text.isNotEmpty} ,${pincodeController.text.isNotEmpty}, ${cityController.text.isNotEmpty}";
      } else {
        throw Exception('Please enter all Values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackbar(context, 'Error');
    }
  }

  void googlePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      adressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    adressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity - 10,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black12,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 19),
                    )
                  ],
                ),
              const SizedBox(height: 20),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      obscureText: false,
                      controller: flatBuildingController,
                      hintText: 'Flat , House No , Building',
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      obscureText: false,
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      obscureText: false,
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      obscureText: false,
                      controller: cityController,
                      hintText: 'City / Town',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GooglePayButton(
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                onPaymentResult: googlePayResult,
                paymentItems: paymentItems,
                margin: const EdgeInsets.all(5),
                width: double.infinity - 10,
                type: GooglePayButtonType.pay,
              ),
              // GooglePayButton(
              //   onPressed: () => payPressed(address),
              //   paymentConfigurationAsset: 'gpay.json',
              //   onPaymentResult: googlePayResult,
              //   paymentItems: paymentItems,
              //   height: 50,
              //   type: GooglePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15),
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
