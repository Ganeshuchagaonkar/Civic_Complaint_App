import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class Removeofficer extends StatefulWidget {
  @override
  _RemoveofficerState createState() => _RemoveofficerState();
}

class _RemoveofficerState extends State<Removeofficer> {
  final _usercontroller=TextEditingController();
  @override
  void deleteofficer(String userid)async{

  var response=await http.get(Uri.http("192.168.43.187:8000", "users/delete/${int.parse(userid)}")
  ,headers: <String,String>{
    'Content-Type':'application/json; charset=UTF-8',
    
  }
  );
  var res=jsonDecode(response.body);
  if(res['status']==1){
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("User Deleted Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
  }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Admin Dashboard'),),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40),
            new Divider(),
            new ListTile(
              title: new Text(
                'Home',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Admin/Home');
              },
            ),
            Divider(),
            new ListTile(
              title: new Text(
                'Add officer',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Admin/addofficer');
              },
            ),
            Divider(),
            new ListTile(
              title: new Text(
                'Delete Officer',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Admin/removeofficer');
              },
            ),
            Divider(),
            
            new ListTile(
              title: new Text(
                'Complaints',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Admin/Complaints');
              },
            ),
            new Divider(),
          ],
        ),
      ),
        body: Container(
          padding: const EdgeInsets.only(left:30,right:30,top:60),
          child: Column
        (mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                Material(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: TextFormField(
                      
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field is Required";
                            }
                            return null;
                          },
                          controller: _usercontroller,
                          keyboardType: TextInputType.emailAddress,

                          decoration: const InputDecoration(
                            
                             contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            // prefixIcon: Icon(
                            //   Icons.email,
                            //   size: 20,
                            //   color: Colors.black
                            // ),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter the user id',
                            
                             
                            labelText: 'User-id',
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      RaisedButton(
                        color: Colors.purple[900],
                        onPressed: (){
                           deleteofficer(_usercontroller.text);
                      },
                      child: Text('Remove',style: TextStyle(color:Colors.white,fontSize: 20),),)

        ],),),
      
    );
  }
}