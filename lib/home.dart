import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
  List<Widget> futsalsList = [];
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
                            this.FutsalsList = value;
                          });
                        });
                      },
                      child:const Padding(
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
                          child: CircleProgressIndicator(
                            strokeWidth: 3,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                      ]
                    : futsalsList.map(e) => GestureDetector(
                      onTap: (){
                        FutsalsController().futsal(ctx: context, id: e.id!);
                      }
                    ),
              ))
            ],
          )));
}
