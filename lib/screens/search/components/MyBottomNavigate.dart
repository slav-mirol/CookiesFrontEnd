import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../add_recipe/add_recipe_screen.dart';
import '../search_screen.dart';

class MyBottomNavigate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding),
      height: 60,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.2))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pop(null);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) { return SearchPage(); }));
            },
          ),
          Spacer(),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pop(null);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) { return AddRecipe(); }));
            },
          ),
          Spacer()
        ],
      ),
    );
  }
}