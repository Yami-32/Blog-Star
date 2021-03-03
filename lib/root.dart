import 'package:blog_star/home.dart';
import 'package:blog_star/pages/login_screen.dart';
import 'package:blog_star/services/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void initState() {
    super.initState();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String message = _currentUser.onStartUp();
    if (message == 'sucess') {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();

  //   CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
  //   String _returnString = await _currentUser.onStartUp();
  //   if (_returnString == 'sucess') {
  //     setState(() {
  //       _authStatus = AuthStatus.loggedIn;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget = LoginScreen();

    if (_authStatus == AuthStatus.loggedIn) {
      returnWidget = HomeScreen();
    } else {
      returnWidget = LoginScreen();
    }

    return returnWidget;
  }
}
