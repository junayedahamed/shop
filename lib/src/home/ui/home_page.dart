import 'package:flutter/material.dart';

import 'package:ocad/src/home/provider/tab_header_provider.dart';
import 'package:ocad/src/home/ui/tabs/univarsal_tab.dart';
import 'package:ocad/src/home/ui/widget/tab_header_builder.dart';
import 'package:ocad/src/models/product_model/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List tabs = ["Food", "Electronics", "Cloths", "Vegetable"];
  late TabController controller;
  final TabHeaderProvider tabHeaderProvider = TabHeaderProvider();
  // final FavoriteBloc favoriteBloc = FavoriteBloc();
  // final CartBloc cartBloc = CartBloc();
  //
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    // favoriteBloc.add(FavoriteDataInitialEvent());
    // cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListenableBuilder(
          listenable: tabHeaderProvider,
          builder: (context, asyncSnapshot) {
            return TabBar(
              dividerColor: null,
              controller: controller,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              automaticIndicatorColorAdjustment: true,
              indicator: BoxDecoration(color: null),
              // physics: NeverScrollableScrollPhysics(),
              onTap: (value) {
                tabHeaderProvider.changeSelection(value);
              },
              dividerHeight: 0,
              tabs: [
                Tab(
                  child: TabHeaderBuilder(
                    name: tabs[0],
                    tabIndex: 0,
                    selected: tabHeaderProvider.selected,
                  ),
                ),
                Tab(
                  child: TabHeaderBuilder(
                    name: tabs[1],
                    tabIndex: 1,
                    selected: tabHeaderProvider.selected,
                  ),
                ),
                Tab(
                  child: TabHeaderBuilder(
                    name: tabs[2],
                    tabIndex: 2,
                    selected: tabHeaderProvider.selected,
                  ),
                ),
                Tab(
                  child: TabHeaderBuilder(
                    name: tabs[3],
                    tabIndex: 3,
                    selected: tabHeaderProvider.selected,
                  ),
                ),
              ],
            );
          },
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            // children: [FoodTab(), ElectronicsTab(), ClothTab(), DataTab()],
            children: [
              UniversalTab(category: Category.food),
              UniversalTab(category: Category.electronics),
              UniversalTab(category: Category.cloths),
              UniversalTab(category: Category.vegetable),
            ],
          ),
        ),
      ],
    );
  }
}
