import 'package:flutter/material.dart';
import 'package:test1/constants.dart';
import 'package:test1/screens/add_recipe/components/body.dart';
import 'package:test1/screens/search/components/MyBottomNavigate.dart';

class AddRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavigate(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: const Text("Add Recipes"),
      backgroundColor: kPrimaryColor,
    );
  }
}