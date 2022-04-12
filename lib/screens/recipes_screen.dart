import 'package:flutter/material.dart';
import 'package:test1/recipe.dart';

class RecipesScreen extends StatefulWidget {
  List<Recipe> recipes;

  RecipesScreen(this.recipes);

  @override
  _RecipesScreenState createState() => _RecipesScreenState(recipes);
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<Recipe> recipes;

  _RecipesScreenState(this.recipes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
          backgroundColor: Colors.deepPurple[300],
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: recipes.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 0.3)),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          color: Theme.of(context).primaryColor,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(recipes[index].name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: "assets/fonts/tenor_sans.ttf",
                                fontSize: 30)),
                      ),
                      Container(
                        child: Text(
                          recipes[index].description,
                          style: const TextStyle(
                              fontFamily: "assets/fonts/tenor_sans.ttf",
                              fontSize: 18),
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                      Container(
                        child: Image.network(recipes[index].photo),
                        padding: const EdgeInsets.all(10),
                      ),
                    ],
                  ));
            }));
  }
}
