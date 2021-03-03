import 'package:blog_star/pages/description_screen.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  final imageUrl;
  final String authorName;
  final String title;
  final String blogData;

  BlogTile(
      {@required this.imageUrl,
      @required this.authorName,
      @required this.title,
      @required this.blogData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Description(
                          title: title,
                          author: authorName,
                          data: blogData,
                        )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: Text(
                  '$title',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$authorName',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
