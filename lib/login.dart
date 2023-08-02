import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required String title}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late String username, password;
  late bool error, showProgress;
  late String errormsg;

  final _username = TextEditingController();
  final _password = TextEditingController();

  bool _isVisible = false;
  bool _isVisible1 = false;
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void updateStatus1() {
    setState(() {
      _isVisible1 = !_isVisible1;
    });
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showProgress = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 60),
                  const CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage("lib/assets/futsal.png"),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _username,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        labelText: 'Phone No.',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.5))),
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _password,
                    obscureText: _isVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            updateStatus();
                          },
                          child: Icon(
                            _isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.5))),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Forgot Password?",
                          style: TextStyle(fontSize: 13, color: Colors.black)),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Click Here",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 13,
                                  color: Colors.black))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      height: 50,
                      color: Colors.teal,
                      minWidth: 350,
                      textColor: Colors.white,
                      child: const Text("LOGIN"),
                      onPressed: () {
                        if (_username.text == "" || _password.text == "") {
                          Fluttertoast.showToast(
                            msg: "Email or Password field left blank!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            fontSize: 16.0,
                            textColor: Colors.black,
                            backgroundColor: Colors.redAccent,
                          );
                        } else {
                          // LoginController().login(
                          //     email: _username.text,
                          //     password: _password.text,
                          //     ctxt: context);
                        }
                        splashColor:
                        Colors.redAccent;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        "Don't have Account?",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ],
    ));
  }
}
