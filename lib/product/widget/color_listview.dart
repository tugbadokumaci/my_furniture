import 'package:flutter/material.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/init/theme/light/color_scheme_light.dart';

import '../model/color_model.dart';

class ColorListView extends StatefulWidget {
  List<ColorModel> colors;
  final Function(int) onColorSelected;
  ColorListView({super.key, required this.colors, required this.onColorSelected});

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {
  int _selectedValueIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.colors.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          _changeValue(index);
        },
        child: _buildColorColumn(widget.colors[index], index),
      ),
    );
  }

  void _changeValue(int index) {
    _selectedValueIndex = index;
    setState(() {});
    widget.onColorSelected(index);
  }

  Widget _buildColorColumn(ColorModel colorModel, int index) => Column(
        children: [
          // Expanded(child:
          _buildColorCircleAvatar(colorModel, index),
          // ),
          // Expanded(child: Text(colorModel.colorName)),
        ],
      );

  Widget _buildColorCircleAvatar(ColorModel colorModel, int index) => Padding(
        padding: context.paddingLow,
        child: CircleAvatar(
          backgroundColor: Color(int.parse('0xff${colorModel.colorHEXCode}')),
          radius: index == _selectedValueIndex ? 15 : 21,
        ),
      );
}
