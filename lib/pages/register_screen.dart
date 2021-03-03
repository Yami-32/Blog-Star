import 'package:blog_star/modules/constants.dart';
import 'package:blog_star/services/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showLoader = false;

  void _registerUser(
      {BuildContext context,
      String password,
      String email,
      BuildContext scafContext}) async {
    CurrentUser _user = Provider.of<CurrentUser>(context, listen: false);
    try {
      setState(() {
        _showLoader = true;
      });
      String message =
          await _user.registerUser(email: email, password: password);
      setState(() {
        _showLoader = false;
      });
      if (message == 'sucess') {
        Navigator.pop(context);
      } else {
        setState(() {
          _showLoader = false;
        });
        Fluttertoast.showToast(
          msg: message,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: _showLoader
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: 120,
                        width: 80,
                        child: Image.asset(
                          'images/logo.png',
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: kTextFileDecoration,
                    //InputDecoration(border: InputBorder.none, hintText: 'Email ID'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    decoration:
                        kTextFileDecoration.copyWith(hintText: 'Password'),
                    //InputDecoration(border: InputBorder.none, hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (ctx) => FlatButton(
                      onPressed: () {
                        _registerUser(
                            context: context,
                            password: _passwordController.text,
                            email: _emailController.text,
                            scafContext: ctx);
                      },
                      child: Text(
                        'Register',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
