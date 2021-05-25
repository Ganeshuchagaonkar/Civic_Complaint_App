import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image ,width:100,height: 10,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        // tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}