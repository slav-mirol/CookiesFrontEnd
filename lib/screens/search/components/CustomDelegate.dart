import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/product.dart';
import 'package:test1/services/networkHelper.dart';

class CustomDelegate<T> extends SearchDelegate<T> {
  final List<Product> data;

  //final String value;
  var exit;

  CustomDelegate(this.data) {}

  Future<List<Product>> getListProduct() async {
    String url = ("http://localhost:8080/products/search?productName=" + query);
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
    Size size = MediaQuery.of(context).size;
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
                var noun = snapshot.data![i].name;
                return ListTile(
                  title: Row(children: [
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.07,
                      child: Image.network(snapshot.data![i].photo,
                          fit: BoxFit.fill),
                    ),
                    Text(snapshot.data![i].name)
                  ]),
                  onTap: () => close(context, noun),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
