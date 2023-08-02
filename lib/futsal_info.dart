import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:futshal/controller/ip.dart';
import 'package:futshal/model/futsal.dart';
import 'package:futshal/model/get_futsal.dart';
import 'package:futshal/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:basics/date_time_basics.dart';
import 'package:futshal/widgets/NavigationService.dart';

class FutsalInfo extends StatefulWidget {
  FutsalInfo({this.getFutsal});
  GetFutsal? getFutsal;
  // const RestaurantInfo({Key? key}) : super(key: key);
  @override
  _FutsalInfo createState() => _FutsalInfo();
}

class _FutsalInfo extends State<FutsalInfo> {
  // List<Widget> _pages() {
  //   return widget.getFutsal!.categories!
  //       .map(
  //         (e) => getFoods(
  //           foods: e.getFoods!,
  //         ),
  //       )
  //       .toList();
  // }

  // FavouriteProvider? _favProvider;
  UserProvider userProvider = Provider.of<UserProvider>(
      NavigationService.navigatorKey.currentContext!,
      listen: false);

  List<String?> _title = [""];

  int index = 0;
  bool isOpen = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String _selectedText = _title.first.toString();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   this._title = widget.getFutsal!.categories!.map((e) => e.name).toList();
    // });

    var now = DateTime.now();

    var start = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(widget.getFutsal!.openFrom!.split(":")[0]), //hour
      int.parse(widget.getFutsal!.openFrom!.split(":")[1]), //min
      int.parse(widget.getFutsal!.openFrom!.split(":")[2]), //sec
    );
    var end = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(widget.getFutsal!.closeAt!.split(":")[0]), //hour
      int.parse(widget.getFutsal!.closeAt!.split(":")[1]), //min
      int.parse(widget.getFutsal!.closeAt!.split(":")[2]), //sec
    );
    print(start.toString());
    print(end.toString());

    setState(() {
      if (start <= now && end >= now) {
        this.isOpen = true;
      } else {
        this.isOpen = false;
      }
    });

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.getFutsal!.name.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
            // margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/pokhara.jpg",
                      height: 230,
                    ),
                    Positioned(
                      top: 160,
                      right: MediaQuery.of(context).size.width / 3.0,
                      //bottom: 0.5,
                      child: Container(
                        height: 100,
                        width: 130,
                        child: Positioned(
                          // left: 8,
                          // bottom: 10,
                          child: Image.network(
                            host_public + widget.getFutsal!.logo.toString(),
                            height: 100,
                            width: 130,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                //Image.asset("assets/pokhara.jpg"),
                Text(
                  widget.getFutsal!.name.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.getFutsal!.address.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  this.isOpen ? "Open" : "Close",
                  style: TextStyle(color: Colors.green, fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 500,
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: this._title.mapIndexed((index, title) {
                      return Container(
                        margin: EdgeInsets.only(right: 5),
                        child: MaterialButton(
                          elevation: 3.0,
                          //splashColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          minWidth: 30,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              print(index);
                              this.index = index;
                            });
                          },
                          child: Text(
                            title.toString(),
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                // _pages().elementAt(this.index),
                SizedBox(height: 15.0),

                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Colors.orangeAccent),
                //   height: 100,
                //   child:,
                // ),
              ],
            )),
      ),
    );
  }
}
