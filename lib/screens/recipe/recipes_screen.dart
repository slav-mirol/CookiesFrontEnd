import 'package:flutter/material.dart';
import 'package:test1/constants.dart';
import 'package:test1/recipe.dart';
import 'package:test1/screens/recipe/components/player_widget_controller.dart';
import 'package:test1/screens/search/components/MyBottomNavigate.dart';

class RecipesScreen extends StatefulWidget {
  Recipe recipe;

  RecipesScreen(this.recipe);

  @override
  _RecipesScreenState createState() => _RecipesScreenState(recipe);
}

class _RecipesScreenState extends State<RecipesScreen> {
  final Recipe recipe;

  _RecipesScreenState(this.recipe);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Recipe: " + recipe.name, textAlign: TextAlign.center,),
          backgroundColor: kPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
                    width: size.width / 2,
                    child: Image.network(recipe.photo),
                  ),

                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        width: size.width / 2,
                        child: Text(recipe.description, style: const TextStyle(fontSize: 20, ),)
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        width: size.width / 2,
                        child: Text(recipe.date, style: const TextStyle(fontSize: 20, ), textAlign: TextAlign.left,)
                      )
                    ],
                  ),
                ],
              ),
              Container(
                height: size.height * 0.8,
                child: NetworkPlayerController(url: recipe.video),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavigate(),
    );
  }
}
