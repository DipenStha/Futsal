import 'package:flutter/material.dart';
import 'package:futshal/login.dart';
import 'package:futshal/provider/user_provider.dart';
import 'package:futshal/register.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'main_page.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => UserProvider()),
        // ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        // ChangeNotifierProvider.value(value: FavouriteProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MaterialApp(
        // navigatorKey: NavigationService.navigatorKey, // set property
        debugShowCheckedModeBanner: false,
        // initialRoute: 'food_items',
        // initialRoute: 'restaurantinfo',
        // initialRoute: 'pick_image',
        //initialRoute: 'stepperpage',
        // initialRoute: 'user_form',
        // initialRoute: 'deliveryaddress',
        initialRoute: 'home_page',
        // initialRoute: 'register',
        // initialRoute: 'email_authentication',
        routes: {
          'login': (context) => const MyLogin(
                title: "Futsal",
              ),
          'register': (context) => const MyRegister(),
          'main_page': (context) => const MainPage(),
          'home_page': (context) => const HomePage(),
        },
      )));
}
