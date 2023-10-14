import 'package:flutter/material.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/product/model/product_model.dart';

import '../../view/product/view/product_view.dart';
import '../init/theme/light/color_scheme_light.dart';
import '../init/theme/light/text_theme_light.dart';

class ProductDisplayTile extends StatelessWidget {
  final ProductModel productModel;
  const ProductDisplayTile({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductView(productModel: productModel)));
      },
      child: SizedBox(
          height: context.dynamicHeight(0.5),
          child: Card(
            color: ColorSchemeLight.instance.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: context.paddingLow,
                    child: Card(child: Image.network(productModel.productImage.first)),
                  ),
                ),
                Padding(
                  padding: context.paddingLow,
                  child: Text(productModel.productName, style: TextThemeLight.instance.TextSmall),
                ),
                Padding(
                  padding: context.paddingLow,
                  child: Text('\$${productModel.productPrice}',
                      style: TextThemeLight.instance.TitleMedium.copyWith(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          )),
    );
  }
}
