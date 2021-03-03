import 'package:blog_star/modules/blog_tile.dart';
import 'package:blog_star/services/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _emailId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  fetchUser() {
    CurrentUser _usr = Provider.of<CurrentUser>(context, listen: false);
    _emailId = _usr.getEmail();
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Flexible(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          height: 140,
                          child: Image.asset(
                            'images/logo.png',
                            fit: BoxFit.fitHeight,
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '$_emailId',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.amber),
              ),
              Builder(
                  builder: (context) => Container(
                        child: FlatButton(
                            onPressed: () async {
                              CurrentUser _currentUser =
                                  Provider.of<CurrentUser>(context,
                                      listen: false);
                              String message = await _currentUser.signOut();
                              if (message == 'sucess') {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (route) => false);
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(message),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Text(
                              'Log out',
                              style: TextStyle(fontSize: 18),
                            )),
                      )),
              Divider(
                indent: 40,
                endIndent: 40,
                color: Colors.amber,
                thickness: 2,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/blog');
                },
                child: Text(
                  'Add Blog',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Center(
            child: Row(
              children: <Text>[
                Text(
                  'Blog',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Star',
                  style: TextStyle(color: Colors.amber),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: BlogStream(
            firestore: _firestore,
          ),
        ));
    // body: BlogStream(
    //   firestore: _firestore,
    // ));
  }
}

class BlogStream extends StatelessWidget {
  final FirebaseFirestore _firestore;

  const BlogStream({Key key, FirebaseFirestore firestore})
      : _firestore = firestore,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Blogs').snapshots(),
      builder: (context, snapshot) {
        List<BlogTile> blogList = [];
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final totalInfo = snapshot.data.docs;

        for (var info in totalInfo) {
          final infoData = info.data();
          final author = infoData['author'];
          final title = infoData['title'];
          final imageUrl = infoData['image'];
          final blogData = infoData['description'];
          final blogWidget = BlogTile(
            imageUrl: imageUrl,
            authorName: author,
            title: title,
            blogData: blogData,
          );
          blogList.add(blogWidget);
        }
        return ListView(
          children: blogList,
        );
      },
    );
  }
}
