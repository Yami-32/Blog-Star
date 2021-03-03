import 'package:blog_star/modules/constants.dart';
import 'package:blog_star/services/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showProgress = false;

  //FirebaseAuth _auth = FirebaseAuth.instance;

  void _signInUser(
      {BuildContext context,
      String email,
      String password,
      BuildContext scaffoldContex}) async {
    CurrentUser _user = Provider.of<CurrentUser>(context, listen: false);
    setState(() {
      _showProgress = true;
    });
    try {
      String message = await _user.loginUSer(password: password, email: email);
      setState(() {
        _showProgress = false;
      });

      if (message == 'sucess') {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(
          msg: message,
        );
        // Scaffold.of(scaffoldContex).showSnackBar(SnackBar(
        //   content: Text('$message'),
        //   duration: Duration(seconds: 4),
        // ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: _showProgress
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
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
                      decoration:
                          kTextFileDecoration.copyWith(hintText: 'Email ID'),
                      controller: _emailController,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          kTextFileDecoration.copyWith(hintText: 'Password'),
                      controller: _passwordController,
                    ),
                    SizedBox(height: 10),
                    Builder(
                      builder: (ctx) => FlatButton(
                        onPressed: () {
                          _signInUser(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text,
                              scaffoldContex: ctx);
                        },
                        child: Text(
                          'Login',
                          style: kSendButtonTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text('Register new User'))
                  ],
                ),
              ),
            ),
    );
  }
}
