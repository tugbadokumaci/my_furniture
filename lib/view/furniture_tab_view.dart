import 'package:flutter/material.dart';
import 'package:my_furniture/view/search/view/search_view.dart';

import 'home/view/home_view.dart';

enum _FurniturePages { home, favorite, bag, profile }

class FurnitureTabView extends StatelessWidget {
  const FurnitureTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _FurniturePages.values.length,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TabBar(tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.favorite)),
            Tab(icon: Icon(Icons.shopping_cart)),
            Tab(icon: Icon(Icons.person)),
          ]),
        ),
        body: TabBarView(
          children: [
            HomeView(),
            SearchView(),
            SizedBox(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
