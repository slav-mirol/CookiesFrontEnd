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
                    height: size.height * 0.8,
                    child: Image.network(recipe.photo, fit: BoxFit.contain),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          width: size.width / 2,
                          child: Text(recipe.name, style: const TextStyle(fontSize: 30, ),)
                      ),
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Продукты',
                  style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 30),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                height: size.height * 0.3 * recipe.products.length,
                width: size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: recipe.products.length,
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            /*Container(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
                              width: size.width / 2,
                              height: size.height * 0.8,
                              child: Image.network(recipe.photo, fit: BoxFit.contain),
                            ),*/
                            Container(
                              height: size.height * 0.25,
                              child: Image.network(recipe.products[i].photo, fit: BoxFit.contain),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(recipe.products[i].name,
                                  style: const TextStyle(
                                      fontFamily: "assets/fonts/tenor_sans.ttf",
                                      fontSize: 20,
                                      color: Colors.white)),
                            ),
                            Container(
                              width: 10,
                            )
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                      ],
                    );

                  },
                ),
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
