import 'package:flutter/material.dart';
import 'package:test1/constants.dart';

import '../../../recipe.dart';
import '../../../services/networkHelper.dart';
import '../../recipe/recipes_screen.dart';
import 'CustomDelegate.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> _result = [];
  List<String> data = [];
  List<Recipe> recipes = [];
  String search_text = "";

  Future<List<String>> getAllProduct() async {
    String url = "http://localhost:8080/products";
    List<String> all = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> info = data as List;
    for (int i = 0; i < info.length; ++i) {
      all.add(info[i]["name"]);
    }
    return all;
  }

  Future<List<Recipe>> getRecipes(List<String> products) async {
    String url = "http://localhost:8080/recipes/search";
    url += "?product=" + products[0];
    for (int i = 1; i < products.length; ++i) {
      url += "&product=" + products[i];
    }
    List<Recipe> all = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> info = data as List;
    for (int i = 0; i < info.length; ++i) {
      Recipe curRecipe = Recipe(
          name: info[i]["name"],
          description: info[i]["description"],
          photo: info[i]["photo"],
          video: info[i]["video"],
          date: info[i]["date"]);
      all.add(curRecipe);
    }
    return all;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
            height: size.height * 0.2,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 20 + kDefaultPadding),
                  height: size.height * 0.2 - 30,
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      )),
                  child: Row(
                    children: [
                      Text(
                        "Hi, User!",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Image.asset("assets/images/logoTotalWhite2.png"),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.7),
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: kPrimaryColor,
                            onChanged: (value) {
                              search_text = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Введите продукт",
                              hintStyle: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5)),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              data = await getAllProduct();
                              var result = await showSearch<String>(
                                context: context,
                                delegate: CustomDelegate(data, search_text),
                              );
                              if (result != null) {
                                setState(() {
                                  _result.add(result);
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          height: size.height * 0.1,
          width: size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _result.length,
            itemBuilder: (_, i) {
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(_result[i],
                            style: const TextStyle(
                                fontFamily: "assets/fonts/tenor_sans.ttf",
                                fontSize: 15,
                                color: Colors.white)),
                        IconButton(
                            onPressed: () {
                              _result.removeAt(i);
                              setState(() {});
                            },
                            icon: const Icon(Icons.clear, size: 20)),
                      ],
                    ),
                  ),
                  Container(
                    width: 10,
                  )
                ],
              );
            },
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              recipes = await getRecipes(_result);
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //  return RecipesScreen(recipes);
              //}));
              setState(() {});
            },
            child: const Text("Print Recipes..."),
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            height: size.height * 0.6 - 90,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            color: kPrimaryColor.withOpacity(0.5), width: 0.3),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                color: kPrimaryColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                  onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) { return RecipesScreen(recipes[index]); }));
                                  },
                                  child: Text(recipes[index].name,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontFamily:
                                              "assets/fonts/tenor_sans.ttf",
                                          fontSize: 30)),
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                  ))
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
                            child: Image.network(recipes[index].photo, height: 1200,),
                            padding: const EdgeInsets.all(10),
                          ),
                        ],
                      ));
                })),
      ],
    );
  }
}