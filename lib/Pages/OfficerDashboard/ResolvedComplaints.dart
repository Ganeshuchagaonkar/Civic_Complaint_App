import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class ResolvedIssue extends StatefulWidget {
  @override
  _ResolvedIssueState createState() => _ResolvedIssueState();
}

class _ResolvedIssueState extends State<ResolvedIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Resolved Issue'),),
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child:ResolvedView(),
            ),
          ]
      ),
      )
    );
  }
}


class ResolvedView extends StatefulWidget {
  @override
  _ResolvedViewState createState() => _ResolvedViewState();
}
List resolvedcomp;
class _ResolvedViewState extends State<ResolvedView> {
  @override
  void initState() { 
    super.initState();
    _resolvedissue();
  }
  @override
  void _resolvedissue()async{
    String user_id;
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
          user_id=prefs.get('userid').toString();
        });
    var res=await http.get(Uri.http("192.168.43.187:8000", "complaints/resolvedcomplaints/$user_id"),headers: <String,String>{
  'Content-Type':'application/jsone;  charset=UTF-8'
});
 setState(() {
   print(jsonDecode(res.body));
    resolvedcomp=jsonDecode(res.body);
  });
  }
  Widget build(BuildContext context) {
    return resolvedcomp.length>0? ListView.builder(
    itemCount:resolvedcomp.length,
    itemBuilder:(context,index) {
      return ExpansionTile(
   
   title: Text(resolvedcomp[index]["comp_title"],

   
   ),
   children: [
     Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Title :",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
         Text(resolvedcomp[index]["comp_title"])
       ],
     ),
     SizedBox(height:20),
 Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Complaint Date :",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width:20),
         Text(resolvedcomp[index]["comp_date"])
       ],
     ),
      SizedBox(height:10),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Description:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
        Container(
                        padding: EdgeInsets.only(top: 20),
                        width: 150,
                        child: Text(
                          resolvedcomp[index]['comp_desc'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          textAlign: TextAlign.justify,
                        ),
                      )
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Progress:",style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(width:20),
         Text(resolvedcomp[index]["progress"].toString())
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Status:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
         Text(resolvedcomp[index]["status"]),
      SizedBox(height:20) 
       ],
        
     )

 ],
 );
    },
  ):
  Center(child:Text('No resolved issue') ,);

  }
}