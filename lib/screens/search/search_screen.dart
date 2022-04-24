import 'package:flutter/material.dart';
import 'package:test1/constants.dart';
import 'components/MyBottomNavigate.dart';
import 'components/body.dart';

class SearchPage extends StatelessWidget {
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
      /*leading: IconButton(
          icon: const Icon(Icons.accessibility),
          onPressed: (){},
        ),*/
      title: const Text("Search Recipes"),
      backgroundColor: kPrimaryColor,
    );
  }
}


