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
                    width: size.width * 0.4,
                    height: size.width * 0.25,
                    child: Image.network(recipe.photo, fit: BoxFit.fill),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          width: size.width / 2,
                          child: Text(recipe.name, style: const TextStyle(fontFamily: "norm", fontSize: 80, color: Colors.deepPurple),)
                      ),
                      Text(""),
                      Text(""),
                      Text(""),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        width: size.width / 2,
                        child: Text(recipe.description, style: const TextStyle(fontFamily: "norm", fontSize: 30),)
                      ),
                      Text(""),
                      Text(""),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        width: size.width / 2,
                        child: Text(recipe.date, style: const TextStyle(fontFamily: "norm", fontSize: 30), textAlign: TextAlign.right,)
                      )
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Ingredients',
                  style: TextStyle(fontFamily: "norm", fontSize: 50, color: Colors.deepPurple),
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
                              width: size.height * 0.35,
                              child: Image.network(recipe.products[i].photo, fit: BoxFit.fill),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(recipe.products[i].name,
                                  style: const TextStyle(
                                      fontFamily: "norm",
                                      fontSize: 40,
                                      color: Colors.black
                                  )),
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
