import 'package:flutter/material.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/init/theme/light/text_theme_light.dart';
import 'package:my_furniture/product/model/category_model.dart';
import 'package:my_furniture/view/category/view/category_view.dart';

class CategoryDisplayTile extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryDisplayTile({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CategoryView(categoryName: categoryModel.categoryName)));
      },
      child: SizedBox(
        width: context.dynamicWidth(0.5),
        child: Card(
          child: Stack(
            children: [
              Image.network(categoryModel.categoryImage, fit: BoxFit.fitWidth),
              Positioned(
                top: context.dynamicHeight(0.02),
                left: context.dynamicWidth(0.05),
                child: Text(categoryModel.categoryName, style: TextThemeLight.instance.TitleMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
