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

  Future<List<Recipe>> getAllRecipes() async {
    String url = "http://localhost:8080/recipes";
    List<Recipe> all = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> info = data as List;
    for (int i = 0; i < info.length; ++i) {
      Recipe curRecipe = Recipe(name: info[i]["name"], description: info[i]["description"], photo: info[i]["photo"], video: info[i]["video"]);
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
            Text(_result == [] ? "Пока не выбрано ни одного продукта" : _result.toString(), style: const TextStyle(fontSize: 18)),
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
                if  (result != null) {
                  setState(() {
                    _result.add(result);
                  });
                }
              },
              child: const Text("Search"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[300],
                )
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  recipes = await getAllRecipes();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) { return RecipesScreen(recipes); }));
                  //setState((){});
                },
                child: const Text("Print Recipes..."),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[300],
                )
            ),
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
  List<Widget> buildActions(BuildContext context) => [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => close(context, exit));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    var listToShow;
    if (query.isNotEmpty) {
      listToShow = data.where((e) => e.contains(query) && e.startsWith(query)).toList();
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