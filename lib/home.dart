import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:futshal/controller/futsal_controller.dart';
import 'package:futshal/controller/ip.dart';
import 'package:futshal/model/futsal.dart';

import 'cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FustsalApp(),
    );
  }
}

class FustsalApp extends StatefulWidget {
  FustsalApp({Key? key}) : super(key: key);

  @override
  State<FustsalApp> createState() => _FustsalAppState();
}

class _FustsalAppState extends State<FustsalApp> {
  TextEditingController search = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopCOntainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
  List<Widget> ListItems = [];
  List<Futsal> futsalsList = [];
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
    FutsalController().futsals().then((value) {
      setState(() {
        futsalsList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(context, new MaterialPageRoute(builder: (context) => new Notification()))
              },
              icon: Icon(Icons.notifications, color: Colors.black)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Cart()));
              },
              icon: Icon(Icons.shopping_cart, color: Colors.black))
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orangeAccent,
      body: getBody(),
    );
  }

  getBody() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Let's Play Football \nBook Futsal Now",
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 1, right: 1),
              // width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search Futsals",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.only(left: 15.0),
                    ),
                  )),
                  const SizedBox(
                    width: 1.0,
                  ),
                  MaterialButton(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      FutsalController()
                          .futsals(name: this.search.text)
                          .then((value) {
                        setState(() {
                          this.futsalsList = value;
                        });
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      ),
                    ),
                    color: Colors.white70,
                    splashColor: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              "Featured Futsals",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: ListView(
                children: futsalsList.length == 0
                    ? [
                        Center(
                          widthFactor: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                      ]
                    : futsalsList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              FutsalController()
                                  .futsal(ctx: context, id: e.id!);
                            },
                            child: Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                //margin: const EdgeInsets.only(right: 1),
                                // width: double.infinity,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: StreamBuilder<CupertinoSlider>(
                                    stream: null,
                                    builder: (context, snapshot) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0)),
                                          Image.network(
                                            host_public + e.logo.toString(),
                                            height: 90,
                                            width: 110,
                                          ),
                                          const SizedBox(width: 15.0),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 11.0)),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        e.name.toString(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        softWrap: true,
                                                        // overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  e.address.toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                const Text(
                                                  "_________________________________",
                                                  style: TextStyle(
                                                      color: Colors.blueAccent),
                                                ),
                                                Container(
                                                    //width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 1.0,
                                                            right: 1,
                                                            left: 1),
                                                    //alignment: Alignment.bottomRight,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 6.0),
                                                    height: 25.0,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 177.0,
                                                        ),
                                                        Text(
                                                          this.isOpen
                                                              ? "Open"
                                                              : "Close",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
