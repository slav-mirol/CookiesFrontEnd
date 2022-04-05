import 'package:flutter/material.dart';
import 'package:test1/screens/find_product.dart';
import 'search_screen.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String image = "https://cdn.pixabay.com/photo/2018/03/11/09/08/cookie-3216243_960_720.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logoTotalWhite2.png"),
        toolbarHeight: 120,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 15,
              ),
              Container(
                height: 15,
              ),
              const Text(
                'Welcome to Cookies!',
                style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 30),
              ),
              Container(
                height: 15
              ),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) { return SearchPage(); }));
                },
                child: Text(
                  "Go to search recipes!",
                  style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 30),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[300],
                )
              ),
                Container(
                    child: Image.network(image)
                )
          ],
        ),
      ),
    )
    );
  }
}