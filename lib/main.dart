import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map pokeData;

  List pokeList;

  Future getData() async {
    http.Response pokeResponse;

    pokeResponse = await http.get(
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');

    pokeData = json.decode(pokeResponse.body);
    pokeList = pokeData['pokemon'];
    print(pokeList);
  }

  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
        appBar: AppBar(
          title: Text("PokeDex"),
          backgroundColor: Colors.pink[200],
        ),
        body: pokeList == null
            ? Center(child: Text("Wait"))
            : ListView.builder(
                itemCount: pokeList == null ? 0 : pokeList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                            pokeList[index]['name'],
                            style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                          
                          ),
                                ),
                          Image.network(
                            pokeList[index]['img'],
                            width: 200,
                            height: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Candy: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                          Text(pokeList[index]['candy'],
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 10,),

                              ],
                            ),
                          ),
                        )
                                               ],
                    ),
                  );
                },
              ));
  }
}
