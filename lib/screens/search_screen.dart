import 'package:flutter/material.dart';
import 'package:test1/screens/recipes_screen.dart';
import 'package:test1/services/networkHelper.dart';
import 'package:test1/recipe.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _result = [];
  List<String> data = [];
  List<Recipe> recipes = [];

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
    for (int i = 1; i< products.length; ++i) {
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
          video: info[i]["video"]);
      all.add(curRecipe);
    }
    return all;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              width: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _result.length,
                itemBuilder: (_, i) {
                  return Row(
                    children: [
                      Container(width: 10),
                      Text(_result[i], style: const TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 15)),
                      Container(width: 10),
                      IconButton(onPressed: () {
                        _result.removeAt(i);
                        setState((){});
                      }, icon: const Icon(Icons.clear, size: 20))
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  data = await getAllProduct();
                  var result = await showSearch<String>(
                    context: context,
                    delegate: CustomDelegate(data: data),
                  );
                  if (result != null) {
                    setState(() {
                      _result.add(result);
                    });
                  }
                },
                child: const Text("Search"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[300],
                )),
            Container(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  recipes = await getRecipes(_result);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return RecipesScreen(recipes);
                  }));
                  //setState((){});
                },
                child: const Text("Print Recipes..."),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[300],
                )),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDelegate<T> extends SearchDelegate<T> {
  final List<String> data;
  var exit;

  CustomDelegate({required this.data});

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => close(context, exit));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    var listToShow;
    if (query.isNotEmpty) {
      listToShow =
          data.where((e) => e.contains(query) && e.startsWith(query)).toList();
    } else {
      listToShow = data;
    }
    return ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (_, i) {
        var noun = listToShow[i];
        return ListTile(
          title: Text(noun),
          onTap: () => close(context, noun),
        );
      },
    );
  }
}
