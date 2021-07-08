
import 'package:civic_app/Resusable_Component/MainDashboardPage.dart';
import 'package:flutter/material.dart';



class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text("Admin DashBoard"),
          
        ),
        
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
           
              SizedBox(height: 40),
              new Divider(),
              new ListTile(
                title: new Text(
                  'Home',
                 
                ),
                 onTap: (){
                Navigator.pushNamed(context, '/Admin/Home');
              },
              ),
              Divider(),
              new ListTile(
                title: new Text(
                  'Add officer',
                  
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/Admin/addofficer');
                },
               
              ),
              Divider(),
              new ListTile(
                title: new Text(
                  'Delete Officer',
                  
                ),
                onTap: (){
                  Navigator.pushNamed(context,'/Admin/removeofficer');
                },
               
              ),
              Divider(),
              
              new ListTile(
                title: new Text(
                  'Complaints',
                 
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/Admin/Complaints');
                },
                
                
              ),
              new Divider(),
             
            ],
          ),
        ),
        body: MainDashBoardPage(),
        );
  }
}

