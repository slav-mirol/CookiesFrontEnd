import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../product.dart';
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
  bool is_added = false;
  bool error = false;

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

  Widget check() {
    if (!is_added && !error) {
      return ElevatedButton(
          onPressed: () async {
            String url = "http://localhost:8080/recipes/add";
            String curTime = '';
            for (int i = 0; i < 10; ++i) {
              curTime += DateTime.now().toString()[i];
            }
            if (name != '' && description != '' && url_photo != '' && !products.isEmpty) {
              var jsonMap = {
                "name": name,
                "description": description,
                "video": url_video,
                "photo": url_photo,
                "date": curTime
              };
              String jsonStr = jsonEncode(jsonMap);
              //print(jsonStr);
              http.Response response = await http.post(Uri.parse(url),
                  body: jsonStr, headers: {"Content-Type": "application/json"});
              String id_recipe = jsonDecode(response.body)["id"].toString();
              //print(id_recipe);
              for (int i = 0; i < products.length; ++i) {
                String url_id_product =
                    "http://localhost:8080/products/id?productName=" +
                        products[i];
                response = await http.get(Uri.parse(url_id_product));
                //print(response.body);
                String id_product = response.body;
                url = "http://localhost:8080/recipes/" +
                    id_recipe +
                    "/products/" +
                    id_product;
                response = await http.put(Uri.parse(url));
                //print(response.statusCode);
              }
              is_added = true;
            }
            else {
              error = true;
            }
            //print(is_added);
            //print(error);
            setState(() {});
          },
          child: const Text(
            "Добавить рецепт",
            style: TextStyle(
                fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 30),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple[300],
          ));
    } else if (error){
      error = false;
      return const Text('Ошибка: все поля обязательны к заполнению!',
          style: TextStyle(
              fontFamily: "assets/fonts/tenor_sans.ttf",
              fontSize: 30,
              color: Colors.red));
    }
    else {
      is_added = false;
      return const Text('Ваш рецепт успешно добавлен!',
          style: TextStyle(
              fontFamily: "assets/fonts/tenor_sans.ttf",
              fontSize: 30,
              color: Colors.green));
    }
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
                    fontSize: 30,
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
            child: TextField(
              onChanged: (value) {
                name = value;
                is_added = false;
                error = false;
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
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Описание",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 30,
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
            child: TextField(
              onChanged: (value) {
                description = value;
                is_added = false;
                error = false;
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
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Изображение",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 30,
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
            child: TextField(
              onChanged: (value) {
                url_photo = value;
                is_added = false;
                error = false;
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
          /*const Padding(
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
          ),*/
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Продукты",
                style: TextStyle(
                    fontFamily: "assets/fonts/tenor_sans.ttf",
                    fontSize: 30,
                    color: kPrimaryColor)),
          ),
          ElevatedButton(
            onPressed: () async {
              List<Product> data = await getAllProduct();
              dynamic result = await showSearch<dynamic>(
                context: context,
                delegate: CustomDelegate(data),
              );
              if (result != null) {
                String chooseProduct = result as String;
                if (!products.contains(chooseProduct)) {
                  products.add(chooseProduct);
                  is_added = false;
                  error = false;
                  setState(() {});
                }
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
                          Text('  ' + products[i],
                              style: const TextStyle(
                                  fontFamily: "assets/fonts/tenor_sans.ttf",
                                  fontSize: 15,
                                  color: Colors.white)),
                          IconButton(
                              onPressed: () async {
                                products.removeAt(i);
                                is_added = false;
                                error = false;
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
          check(),
        ]),
      )
    ]));
  }
}
