import 'package:flutter/material.dart';
import 'package:my_furniture/core/extension/context_extension.dart';

import '../../core/init/theme/light/color_scheme_light.dart';

class FurnitureSlider extends StatefulWidget {
  List<String> images;
  FurnitureSlider({super.key, required this.images});

  @override
  State<FurnitureSlider> createState() => _FurnitureSliderState();
}

class _FurnitureSliderState extends State<FurnitureSlider> {
  int _selectedValueIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        buildPageView(),
        buildListViewCirleIndicator(),
      ],
    );
  }

  PageView buildPageView() {
    return PageView.builder(
      controller: PageController(viewportFraction: 1), // was 0.9
      onPageChanged: _changeValue,
      itemCount: widget.images.length,
      itemBuilder: (context, index) => buildCardImage(widget.images[index]),
    );
  }

  void _changeValue(int index) {
    _selectedValueIndex = index;
    setState(() {});
  }

  Widget buildCardImage(String image) => Card(child: Image.network(image, fit: BoxFit.fill));

  ListView buildListViewCirleIndicator() {
    return ListView.builder(
      itemCount: widget.images.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(context.dynamicWidth(0.01)),
        child: CircleAvatar(
          backgroundColor:
              _selectedValueIndex == index ? ColorSchemeLight.instance.orange : ColorSchemeLight.instance.darkGray,
          radius: 5,
        ),
      ),
    );
  }
}
