import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futshal/controller/ip.dart';
import 'package:futshal/futsal_info.dart';
import 'package:futshal/model/futsal.dart';
import 'package:futshal/model/get_futsal.dart';
import 'package:http/http.dart' as http;

class FutsalController {
  Future<List<Futsal>> futsals({String name = ""}) async {
    List<Futsal> _futs = [];
    var url = Uri.parse(GETFUTSALS + '?name=$name');
    print(GETFUTSALS + '?name=$name');
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      List res = jsonDecode(response.body);
      res.forEach((element) {
        _futs.add(Futsal.fromJson(element));
      });
    } else {
      print(response.body);
    }
    return _futs;
  }

  Future<GetFutsal?> futsal(
      {required int id, required BuildContext ctx}) async {
    GetFutsal? _futs;
    var url = Uri.parse(SHOWRESTAURANTS);
    var response = await http.post(url,
        body: {'id': id.toString()}, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      _futs = GetFutsal.fromJson(res);
      Navigator.push<void>(
        ctx,
        MaterialPageRoute(
          builder: (BuildContext context) => FutsalInfo(
            getFutsal: _futs,
          ),
        ),
      );
      // print(res);
    } else {
      print(response.body);
    }
    return _futs;
  }
}
