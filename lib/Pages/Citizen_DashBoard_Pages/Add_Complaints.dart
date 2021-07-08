import 'dart:convert';

import 'package:civic_app/Resusable_Component/Btn.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_Complaints extends StatefulWidget {
  @override
  _Add_ComplaintsState createState() => _Add_ComplaintsState();
}

class _Add_ComplaintsState extends State<Add_Complaints> {
  File _image;
  File _imagepath;
  File _video;
  File _videopath;
  int statevalue;
  int cityvalue ;
  int user_id;
  var picker = ImagePicker();
  final _title = TextEditingController();
  final _emailController = TextEditingController();
  final _discription = TextEditingController();
  final _addressController = TextEditingController();
  var _imagefilename;
  var _videofilename;
 

  @override
  void initState() {
    super.initState();
    getlocalstoragedata();
  }
 void getlocalstoragedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
      setState(() {
             cityvalue = prefs.get("city");
              statevalue = prefs.get("state");
              user_id=prefs.get('userid');

            });
  
  }
  void addcomplaints(
      String title, String description, String address) async {
        print(_imagefilename);
        print(_image.path);
        String url= "http://192.168.43.187:8000/complaints/addcomplaint/";
        var request=http.MultipartRequest('POST',Uri.parse(url));
        request.files.add( http.MultipartFile('comp_image', File(_image.path).readAsBytes().asStream(),File(_image.path).lengthSync(),filename: _image.path.split('/').last));
        request.files.add( http.MultipartFile('comp_video',File( _video.path).readAsBytes().asStream(),File( _video.path).lengthSync(),filename:  _video.path.split('/').last));
       
        request.fields['comp_title']=title;
        request.fields['comp_desc']=description;
        request.fields['comp_by']=user_id.toString();
        request.fields['address']=address;
        request.fields['country']="india";
        request.fields['state_id']=statevalue.toString();
        request.fields['city_id']=cityvalue.toString();
 var res=await request.send();

 if(res.statusCode==200){
   ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("Complaint registred Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
 }
    
  }

 



  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        setState(() {
                  _image = File(pickedFile.path);
        _imagepath = File(_image.path);
        _imagefilename=_imagepath.path.split('/').last;
                });
      
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> getVideo() async {
    var pickedFile = await picker.getVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);

        _videopath = File(_video.path.split('/').last);
        _videofilename=_videopath.path;
      } else {
        print('No video selected.');
      }
    });
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text("Add Complaints"),
      ),
      drawer: new Drawer(
        child: ListView(
          children: [
            SizedBox(height: 40),
            // IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     }),
            Divider(),
            ListTile(
              title: Text("Latest Complaints"),
              onTap: () {
                Navigator.of(context).pushNamed('/citizenDashboard');
              },
            ),
            Divider(),
            ListTile(
              title: Text("Profile"),
              onTap: () {
                Navigator.of(context).pushNamed("/citizenDashboard/profile");
              },
            ),
            Divider(),
            ListTile(
              title: Text("Add Complaints"),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/citizenDashboard/AddComplaints');
              },
            ),
            Divider(),
            ListTile(
              title: Text("View Complaints"),
              onTap: () {
                Navigator.of(context).pushNamed('/citizenDashboard');
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Complaints",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      controller: _title,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Title',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      controller: _discription,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Description"),
                    ),
                  ),
                  SizedBox(height: 20),

                  
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Address",
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Enter your  address"),
                    ),
                  ), 
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field is Required";
                              }
                              return null;
                            },
                            // controller: _userNameController,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            initialValue: 'citizen',

                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Material(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            initialValue: 'India',
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          color: Colors.purple[900],
                          onPressed: getImage,
                          child: Text(
                            'Upload Image',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.purple[900]),
                          ),
                        ),
                        SizedBox(width: 25),
                        Expanded(
                            child: _image == null
                                ? Text('No image selected.')
                                : Text('$_imagepath'))
                      ]),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          color: Colors.purple[900],
                          onPressed: getVideo,
                          child: Text(
                            'Upload Video',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.purple[900]),
                          ),
                        ),
                        SizedBox(width: 25),
                        Expanded(
                            child: _video == null
                                ? Text('No video selected.')
                                : Text('$_videopath'))
                      ]),
                  SizedBox(height: 25),
                  //  TextButton(onPressed:(){

                  //  },style: TextButton.styleFrom(
                  //    primary: Colors.white,
                  //    backgroundColor: Colors.purple[900]
                  //  ), child: Text("Submit"))
                  Btn(
                    text: "Submit",
                    onPress: () {
                      print('hello');
                      String title = _title.text;
                      String description = _discription.text;
                     
                      String address = _addressController.text;

                      addcomplaints(title, description, address);
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
