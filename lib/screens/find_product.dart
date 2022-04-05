import 'package:flutter/material.dart';
import '../services/networkHelper.dart';
class FindProductScreen extends StatefulWidget {
  final String title;

  const FindProductScreen(this.title, {Key? key}) : super(key: key);

  @override
  State<FindProductScreen> createState() => _FindProductScreenState();
}

class _FindProductScreenState extends State<FindProductScreen> {
  String? product;
  late String name;
  Future<List<String>>? products;
  Future<List<String>>? cur_products;
  late String curId;

  void getProduct() async {
    String url = "http://localhost:8080/" + curId;
    product = "";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    product = data["name"] as String;
    print(product);
    setState(() {});
  }
  Future<List<String>> getAllProduct() async {
    String url = "http://localhost:8080/";
    List<String> all = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> info = data as List;
    for (int i = 0; i < info.length; ++i) {
      all.add(info[i]["name"]);
    }
    print(all);
    return all;
    //setState(() {});
  }
  Future<List<String>> hints(String text) async {
    List<String> ans = [];
    List<String>? pro = await products;
    pro ??= [];
    //List<dynamic> pro = products as List;
    for (int i = 0; i < pro.length; ++i) {
      int j = 0;
      int len = 0;
      if (pro[i].length >= text.length) {
        len = text.length;
        while ( j < len && pro[i][j] == text[j]) {
          ++j;
        }
      }
      if (j == len){
        ans.add(pro[i]);
      }
    }
    return ans;
  }
  @override
  void initState() {
    products = getAllProduct();
    product = null;
    name = "";
    curId = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Введите номер продукта'),
            Container(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                curId = value;
                name = value;
                cur_products = hints(name);
              },
            ),
            Container(
              height: 15,
            ),
            ElevatedButton(onPressed: (){ getProduct(); },
                child: const Text("Search")
            ),
            Container(
              height: 15,
            ),
            Text(product == null ? "XXX" : "Result: $product", style: TextStyle(fontSize: 20.0,color: Colors.blue)),

          ],
        ),
      ),
    );
  }
}