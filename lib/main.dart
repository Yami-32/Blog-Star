import 'package:blog_star/home.dart';
import 'package:blog_star/pages/create_blog.dart';
import 'package:blog_star/pages/description_screen.dart';
import 'package:blog_star/pages/login_screen.dart';
import 'package:blog_star/pages/register_screen.dart';
import 'package:blog_star/root.dart';
import 'package:blog_star/services/current_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
          //home: HomeScreen(),
          theme: ThemeData.dark(),
          routes: {
            '/': (context) => RootScreen(),
            '/home': (context) => HomeScreen(),
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/blog': (context) => CreateBlog(),
            '/des': (context) => Description(),
          }),
    );
  }
}
