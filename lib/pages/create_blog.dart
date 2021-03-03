import 'package:blog_star/modules/constants.dart';
import 'package:blog_star/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _authorNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Crud crud = new Crud();

  File selectedImage;
  bool _isLoading = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void uploadBlog(BuildContext ctx) async {
    String messgae;
    if (selectedImage == null) {
      messgae = 'add Image';
    } else if (_titleController.text.length == 0) {
      messgae = 'add title';
    } else if (_descriptionController.text.length == 0) {
      messgae = 'add description';
    }

    if (selectedImage != null &&
        _titleController.text.length != 0 &&
        _descriptionController.text.length != 0) {
      setState(() {
        _isLoading = true;
      });

      Reference _storage = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task = _storage.putFile(selectedImage);

      var imageUrl = await (await task).ref.getDownloadURL();
      print("this is the usl $imageUrl           the url");
      Map<String, dynamic> blogDataMap = {
        "image": imageUrl,
        "author": _authorNameController.text,
        "title": _titleController.text,
        "description": _descriptionController.text,
      };

      await crud.addData(blogDataMap);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: messgae,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: selectedImage != null
                              ? Container(
                                  height: 160,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                    selectedImage,
                                    //fit: BoxFit.cover,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 160,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.black,
                                    ),
                                  )),
                        ),
                        TextField(
                          controller: _titleController,
                          decoration: kBlogTextFileDecuration,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: _authorNameController,
                          decoration: kBlogTextFileDecuration.copyWith(
                              hintText: 'Author Name'),
                        ),
                        Divider(
                          height: 60,
                          indent: 40,
                          endIndent: 40,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 10,
                          decoration: kBlogTextFileDecuration.copyWith(
                              hintText: 'Descritption'),
                        ),
                        Builder(
                          builder: (ctx) => RaisedButton(
                            onPressed: () {
                              uploadBlog(ctx);
                            },
                            child: Text(
                              'Upload',
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
