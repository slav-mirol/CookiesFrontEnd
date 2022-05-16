import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../services/networkHelper.dart';
import '../../search/components/CustomDelegate.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  String name = '';
  String description = '';
  String url_photo = '';
  String url_video = '';
  List<String> products = [];

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Название",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 14,
                    color: kPrimaryColor)),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 44,
            width: size.width * 0.65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 30,
                    color: kPrimaryColor.withOpacity(0.7),
                  )
                ]),
            child: Expanded(
              child: TextField(
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Введите название рецепта",
                  hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Описание",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 14,
                    color: kPrimaryColor)),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 44,
            width: size.width * 0.65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 30,
                    color: kPrimaryColor.withOpacity(0.7),
                  )
                ]),
            child: Expanded(
              child: TextField(
                onChanged: (value) {
                  description = value;
                  setState(() {});
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Введите описание",
                  hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Изображение",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 14,
                    color: kPrimaryColor)),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 44,
            width: size.width * 0.65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 30,
                    color: kPrimaryColor.withOpacity(0.7),
                  )
                ]),
            child: Expanded(
              child: TextField(
                onChanged: (value) {
                  url_photo = value;
                  setState(() {});
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Вставьте ссылку на изображение",
                  hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Видео",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 14,
                    color: kPrimaryColor)),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 44,
            width: size.width * 0.65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 30,
                    color: kPrimaryColor.withOpacity(0.7),
                  )
                ]),
            child: Expanded(
              child: TextField(
                onChanged: (value) {
                  url_video = value;
                  setState(() {});
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Вставьте ссылку на видео",
                  hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Продукты",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 14,
                    color: kPrimaryColor)),
          ),
          ElevatedButton(
            onPressed: () async {
              List<String> data = await getAllProduct();
              String? result = await showSearch<String>(
                context: context,
                delegate: CustomDelegate(data),
              );
              if (result != null && !products.contains(result)) {
                products.add(result);
                setState(() {});
              }
            },
            child: const Text(
              "Выбор продуктов",
              style: TextStyle(
                  fontFamily: "assets/fonts/tenor_sans.ttf",
                  fontSize: 15,
                  color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            ),
          ),
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
                          Text(products[i],
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
          ElevatedButton(
              onPressed: () async {

                String url = "http://localhost:8080/recipes/add";
                var jsonMap = {
                  "name": name,
                  "description": description,
                  "video": url_video,
                  "photo": url_photo,
                  "date" : "2022-05-14"
                };
                String jsonStr = jsonEncode(jsonMap);
                print(jsonStr);
                http.Response response = await http.post(Uri.parse(url), body: jsonStr, headers: {"Content-Type" : "application/json"} );
                String id_recipe = jsonDecode(response.body)["id"].toString();
                print(id_recipe);
                for (int i = 0; i < products.length; ++i) {
                  String url_id_product = "http://localhost:8080/products/id?productName=" + products[i];
                  response = await http.get(Uri.parse(url_id_product));
                  print(response.body);
                  String id_product = response.body;
                  url = "http://localhost:8080/recipes/" + id_recipe + "/products/" + id_product;
                  response = await http.put(Uri.parse(url));
                  print(response.statusCode);
                }
              },
              child: const Text(
                "Добавить рецепт",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 30),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[300],
              )),
        ]),
      )
    ]));
  }
}
