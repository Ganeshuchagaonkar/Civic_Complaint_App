import 'dart:convert';
import 'package:civic_app/config.dart'as config;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class PendingIssue extends StatefulWidget {
  @override
  _PendingIssueState createState() => _PendingIssueState();
}

class _PendingIssueState extends State<PendingIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.purple[900],
         title: Text('Pending Issues'),),
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
         Divider(),
         new ListTile(
              title: new Text(
                'LogOut',
              ),
              onTap: (){
                Navigator.pushNamed(context, '/login');
              },
            ),
            new Divider(),
       ], )
         ),
       body:
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child:PendingView(),
            ),
          ]
      ),
      )
    );
  }
}

class PendingView extends StatefulWidget {
  @override
  _PendingViewState createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  List<dynamic> pendingissue;
  @override
  @override
  void initState() { 
    super.initState();
    pendingIssue();
  }
  void pendingIssue()async{
 String user_id;
 String city_id;
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
          user_id=prefs.get('userid').toString();

          city_id=prefs.get('cityId').toString();
        });
var res=await http.get(Uri.http(config.BaseUrl, "complaints/pending/complaints/$city_id"),headers: <String,String>{
  'Content-Type':'application/jsone;  charset=UTF-8'
});
 pendingissue=jsonDecode(res.body);
 setState(() {
    pendingissue=jsonDecode(res.body);
    print(pendingissue);
  });

  }
  Widget build(BuildContext context) {
    
      
    return pendingissue!=null? ListView.builder(
    itemCount:pendingissue.length,
    itemBuilder:(context,index) {
      return  ExpansionTile(
   
   title: Text(pendingissue[index]['comp_title'],

   
   ),
   children: [
     Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Title :",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
         Text(pendingissue[index]['comp_title'])
       ],
     ),
     SizedBox(height:20),
 Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Complaint Date :",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width:20),
         Text(pendingissue[index]['comp_date'])
       ],
     ),
      SizedBox(height:10),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Description:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
        Container(
          padding: EdgeInsets.only(top:30),
          width:150,
          child : Text(pendingissue[index]['comp_desc'], overflow: TextOverflow.ellipsis,maxLines: 10,textAlign: TextAlign.justify,),)
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Progress:",style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(width:20),
         Text(pendingissue[index]['progress'].toString())
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Status:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
         Text(pendingissue[index]['status'])
       ],
     )

 ],
 );
    }  
  ):
 Center(child: Text("No pending complaints"),);
    
  }
}