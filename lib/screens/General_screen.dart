import 'package:flutter/material.dart';
import 'package:test1/constants.dart';
import 'package:test1/screens/find_product.dart';
import 'search/search_screen.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String image = "https://cdn.pixabay.com/photo/2018/03/11/09/08/cookie-3216243_960_720.jpg";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logoTotalWhite2.png"),
        toolbarHeight: 120,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Cookies!',
                  style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 30),
                ),
                Container(
                  height: 15
                ),
                ElevatedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) { return SearchPage(); }));
                  },
                  child: const Text(
                    "Go to search recipes!",
                    style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 30),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple[300],
                  )
                ),

                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            child: SizedBox(
                              height: size.height * 0.25,
                              child: Image.asset("assets/images/Nikita.png", fit: BoxFit.contain),
                            ),
                          ),
                          const Text("Никита, Teamlead", style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 20)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            child: SizedBox(
                              height: size.height * 0.25,
                              child:
                              Image.asset("assets/images/Slava.png", fit: BoxFit.contain),
                            ),
                          ),
                          const Text("Слава, Frontend - Flutter", style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 20)),
                        ],
                      ),

                      Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            child: SizedBox(
                              height: size.height * 0.25,
                              child:
                              Image.asset("assets/images/Artyom.png", fit: BoxFit.contain),
                            ),
                          ),
                          const Text("Артем, Backend", style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 20)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            child: SizedBox(
                              height: size.height * 0.25,
                              child:
                              Image.asset("assets/images/Dasha.png", fit: BoxFit.contain),
                            ),
                          ),
                          const Text("Даша, Backend", style: TextStyle(fontFamily: "assets/fonts/tenor_sans.ttf", fontSize: 20)),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                ],
        ),
          ),
      ),
    )
    );
  }
}