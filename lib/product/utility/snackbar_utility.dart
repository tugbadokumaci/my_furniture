import 'package:flutter/material.dart';

import '../model/product_model.dart';

class SnackBarUtility {
  static void addProductToCardShowSnackBar({required BuildContext context, required ProductModel productModel}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${productModel.productName} sepete eklendi."),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: "Sepete Git",
          onPressed: () {},
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 30,
      ),
    );
  }
}
