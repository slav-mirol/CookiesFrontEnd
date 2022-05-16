import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/services/networkHelper.dart';

class CustomDelegate<T> extends SearchDelegate<T> {
  final List<String> data;
  //final String value;
  var exit;

  CustomDelegate(this.data) {}

  Future<List<String>> getListProduct() async {
    String url = ("http://localhost:8080/products/search?productName=" + query);
    List<String> all = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> info = data as List;
    for (int i = 0; i < info.length; ++i) {
      all.add(info[i]["name"]);
    }
    return all;
  }

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => close(context, exit));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    var listToShow;
    if (query.isNotEmpty) {
      //listToShow = data.where((e) => e.contains(query)).toList();
      listToShow = http.get(Uri.parse(
          'http://localhost:8080/products/search?productName=' + query));
    } else {
      listToShow = data;
    }
    return FutureBuilder<List<dynamic>>(
        future: getListProduct(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, i) {
                var noun = snapshot.data![i];
                return ListTile(
                  title: Text(noun),
                  onTap: () => close(context, noun),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }
}