import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String title, author, data;

  const Description({Key key, this.title, this.author, this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w300,
                        fontSize: 40),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 40,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  data,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  'by $author',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
