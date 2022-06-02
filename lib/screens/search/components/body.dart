import 'package:flutter/material.dart';
import 'package:test1/constants.dart';
import 'package:test1/product.dart';

import '../../../recipe.dart';
import '../../../services/networkHelper.dart';
import '../../recipe/recipes_screen.dart';
import 'CustomDelegate.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  List<String> products = [];
  List<Product> data = [];
  //List<Recipe> recipes = [];
  String search_text = "";

  Future<List<Product>> getAllProduct() async {
    String url = "http://localhost:8080/products";
    List<Product> all = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> info = data as List;
    for (int i = 0; i < info.length; ++i) {
      Product curProduct = Product(
        name: info[i]["name"],
        photo: info[i]["image"],
      );
      all.add(curProduct);
    }
    return all;
  }

  /*Future<List<Recipe>> getRecipes(List<String> products) async {
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
  }*/

  /*Future<List<Recipe>> getRecipesByName(String name) async {
    String url = "http://localhost:8080/recipes/search/" + name;
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
  }*/

  Future<List<Recipe>> getRecipes(String name, List<String> products) async {
    bool flag = false;
    String url = "http://localhost:8080/recipes/search/filter?";
    if (name != "") {
      url += "recipeName=" + name;
      flag = true;
    }
    if (flag && products.isNotEmpty) {
      url += "&";
    }
    if (products.isNotEmpty) {
      url += "product=";
      for (int i = 0; i < products.length - 1; ++i) {
        url += products[i] + ',';
      }
      url += products[products.length - 1];
    }
    List<Recipe> all = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> info = data as List;
    for (int i = 0; i < info.length; ++i) {
      List<dynamic> curProducts = info[i]["products"] as List;
      List<Product> _products = [];
      for (int j = 0; j < curProducts.length; ++j) {
        Product curProduct = Product(
            name: curProducts[j]["name"],
            photo: curProducts[j]["image"],
        );
        _products.add(curProduct);
      }
      Recipe curRecipe = Recipe(
          name: info[i]["name"],
          description: info[i]["description"],
          photo: info[i]["photo"],
          video: info[i]["video"],
          date: info[i]["date"],
          products: _products
      );
      //print(curRecipe);
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
                      Image.asset("assets/images/logoTotalWhite2.png"),
                      const Spacer(),
                      Text(
                        "",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
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
                            onChanged: (value) {
                              search_text = value;
                              //recipes = await getRecipes(search_text, products);
                              setState(() {});
                            },
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Введите название рецепта",
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
                              dynamic result = await showSearch<dynamic>(
                                context: context,
                                delegate: CustomDelegate(data),
                              );
                              if (result != null) {
                                String chooseProduct = result as String;
                                if (!products.contains(chooseProduct)) {
                                  products.add(chooseProduct);
                                  //recipes =
                                  // await getRecipes(search_text, products);
                                  setState(() {});
                                }
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
            itemCount: products.length,
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
                        Text(' ' + products[i],
                            style: const TextStyle(
                                fontFamily: "assets/fonts/tenor_sans.ttf",
                                fontSize: 15,
                                color: Colors.white)),
                        IconButton(
                            onPressed: () async {
                              products.removeAt(i);
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
        Container(
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            height: size.height * 0.6 - 45,
            child: FutureBuilder<List<Recipe>>(
                future: getRecipes(search_text, products),
                builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color: kPrimaryColor.withOpacity(0.5),
                                    width: 0.3),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.network(
                                            snapshot.data![index].photo,
                                            fit: BoxFit.contain),
                                        height: size.height * 0.6 - 110,
                                        width: size.width * 0.3,
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      SizedBox(
                                        //height: size.height * 0.8,
                                        width: size.width * 0.6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  kDefaultPadding),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return RecipesScreen(
                                                          snapshot.data![index]);
                                                    }));
                                                  },
                                                  child: Text(
                                                      snapshot.data![index].name,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "assets/fonts/Comic_Sans_MS.ttf",
                                                          fontSize: 50,
                                                          color:
                                                              kPrimaryColor)),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  )),
                                            ),
                                            Container(
                                              child: Text(
                                                snapshot.data![index].description,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        "assets/fonts/tenor_sans.ttf",
                                                    fontSize: 30),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row()
                                ],
                              ));
                        });
                  } else {
                    return Container(height: size.height * 0.1,);
                  }
                })),
      ],
    );
  }
}
