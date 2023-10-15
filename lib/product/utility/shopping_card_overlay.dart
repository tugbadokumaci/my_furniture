import 'package:flutter/material.dart';
import 'package:my_furniture/core/extension/context_extension.dart';

import '../../core/init/theme/light/color_scheme_light.dart';
import '../../core/init/theme/light/text_theme_light.dart';
import '../model/color_model.dart';
import '../model/product_model.dart';

class ShoppingCartOverlay extends StatefulWidget {
  final ProductModel productModel;
  final ColorModel colorModel;
  ShoppingCartOverlay(BuildContext context, {Key? key, required this.productModel, required this.colorModel})
      : super(key: key);

  @override
  _ShoppingCartOverlayState createState() => _ShoppingCartOverlayState();
}

class _ShoppingCartOverlayState extends State<ShoppingCartOverlay> {
  late OverlayEntry _overlayEntry;
  List<OverlayEntry> _overlayEntries = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showOverlay();
    });
  }

  void showOverlay() async {
    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: context.dynamicHeight(0.3),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: context.paddingNormal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.network(
                      widget.productModel.productImage.first,
                      width: 100,
                      height: 100,
                    ),
                    Padding(
                      padding: context.paddingNormal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.productModel.productName, style: TextThemeLight.instance.TitleMedium),
                          Text('Selected Color: ${widget.colorModel.colorName}',
                              style: TextThemeLight.instance.TextMedium),
                          Text('\$${widget.productModel.productPrice}',
                              style: TextThemeLight.instance.TitleMedium
                                  .copyWith(color: ColorSchemeLight.instance.orange)),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorSchemeLight.instance.white,
                            side: BorderSide(color: ColorSchemeLight.instance.orange)),
                        onPressed: () {},
                        child: Text('Sepete Git', style: TextStyle(color: ColorSchemeLight.instance.orange)),
                      ),
                    ),
                    context.emptyWidgetWidth(context.normalValue),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: ColorSchemeLight.instance.orange),
                        onPressed: () {},
                        child: Text('Alışverişe Devam Et'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ), // Set the z-index here.
      ),
    );

    _overlayEntries.add(_overlayEntry);
    overlayState!.insert(_overlayEntry);

    await Future.delayed(const Duration(seconds: 5));
    _overlayEntry.remove();
    _overlayEntries.remove(_overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // This widget is not used, but it is required by Flutter.
  }
}
