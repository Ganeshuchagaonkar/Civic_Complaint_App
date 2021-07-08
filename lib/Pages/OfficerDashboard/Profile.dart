import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OfficerProfile extends StatefulWidget {
  @override
  _OfficerProfileState createState() => _OfficerProfileState();
}

class _OfficerProfileState extends State<OfficerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(backgroundColor: Colors.purple[900],
  title: Text("Profile"),),
drawer:new Drawer(
       child: ListView(children: [
          Divider(),
         ListTile( 
           onTap: (){
                        Navigator.pushNamed(context, '/officerDashboard');
           },
           title: Text("Home"),
         ),
         Divider(),
         ListTile(
           title: Text("All Complaints"),
            onTap: (){
             Navigator.pushNamed(context, '/officerDashboard/AllComplaints');
           },
         ),
          Divider(),
          ListTile(
           title: Text("Update Complaints"),
           onTap: (){
             Navigator.pushNamed(context, '/updatecomplaint');
           },
         ),
            Divider(),
         ListTile(
           title: Text("Pending Complaints"),
           onTap: (){
             Navigator.pushNamed(context, '/officerDashboard/Pendingcomplaint');
           },
         ),
            Divider(),
         ListTile(
           title: Text("Resolved Issues"),
           onTap: (){
             Navigator.pushNamed(context, '/officerDashboard/Resolvedcomplaint');
           },
         ),
            Divider(),
        
         ListTile(
           title: Text("Profile"),
        onTap: (){
             Navigator.pushNamed(context, '/officerDashboard/profile');
           },
         ),
       ], )
         ),
      body: DetailProfile(),
    );
  }
}

class DetailProfile extends StatefulWidget {
  @override
  _DetailProfileState createState() => _DetailProfileState();
}
 String name;
  String email;
  int mobile;
  String country;
  String state;
  String city;

class _DetailProfileState extends State<DetailProfile> {
  @override

  void initState() { 
    super.initState();
    profileDetails();
  }
  Future profileDetails()async{
    final SharedPreferences prefs= await SharedPreferences.getInstance();
      setState(() {
         name=prefs.get("officername");
       email=prefs.get("officeremail");
       mobile=prefs.get("officerMobile");
       country=prefs.get("officercountry");
       state=prefs.get("officerstate");
       city=prefs.get("officercity");

      });
      }
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20,left:20, right: 20),
        
        child: SingleChildScrollView(child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:40),
          CircleAvatar(
            backgroundColor: Colors.purple[900],
            child: Text(name[0],style: TextStyle(fontSize: 40,color: Colors.white),),
            radius:40,
          ),
          SizedBox(height:30),
     
          Container(
            margin: EdgeInsets.only(left:45),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(height:30),
                Row( 
                  children: [
                    
                    Text('Name :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold) ),
                    SizedBox(width:30),
                    Text('$name'),

                  ],
                ),
                 SizedBox(height:30),
                Row(
                  children: [
                    Text('Email :' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                     SizedBox(width:30),
                Text('$email'),

                  ],
                ),
                 SizedBox(height:30),
                Row(
                  children: [
                    Text('Mobile No :' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                     SizedBox(width:30),
                    Text('$mobile'),

                  ],
                ),
                 SizedBox(height:30),
                Row(
                  children: [
                    Text('Country :' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                     SizedBox(width:30),
                    Text('$country'),

                  ],
                ),
                 SizedBox(height:30),
                Row(
                  children: [
                    Text('State :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold) ),
                     SizedBox(width:30),
                    Text('$state'),

                  ],
                ),
                 SizedBox(height:30),
                Row(
                  children: [
                    Text('City :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                     SizedBox(width:60),
                    Text('$city'),

                  ],
                ),
              ],
            ),
          ),
        ],),)
      );
  }
}