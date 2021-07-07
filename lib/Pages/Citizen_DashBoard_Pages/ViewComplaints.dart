import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

 class ViewComplaints extends StatefulWidget {
   @override
   _ViewComplaintsState createState() => _ViewComplaintsState();
 }
 
 class _ViewComplaintsState extends State<ViewComplaints> {
   @override
   
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text("All Complaints"),),
      drawer: new Drawer(
        child: ListView(children: [
          
          SizedBox(height:40),
//           IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
//  Navigator.of(context).pop();
//           }),
            Divider(),
          ListTile(
              title: Text("Latest Complaints"),
              onTap: (){
                Navigator.of(context).pushNamed('/citizenDashboard');
              },
          ),
          Divider(),
          ListTile(
            title: Text("Profile"),
            onTap: (){
               Navigator.of(context).pushNamed("/citizenDashboard/profile");
            },
            
          ),
          Divider(),
          ListTile(
              title: Text("Add Complaints"),
              onTap: (){
                Navigator.of(context).pushNamed('/citizenDashboard/AddComplaints');
              },
          ),
           Divider(),
          ListTile(
              title: Text("View Complaints"),
              onTap: (){
                Navigator.of(context).pushNamed('/citizenDashboard/ViewComplaints');
              },
          ), Divider(),
        ],),

      ),
      body:
       Container(
        padding: EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child:MyDyanamicView(),
            ),
          ]
      ),
      )
    );
   }
 }

 
class MyDyanamicView extends StatefulWidget {
  @override
  _MyDyanamicViewState createState() => _MyDyanamicViewState();
}

class _MyDyanamicViewState extends State<MyDyanamicView> {

   var data;
   @override
   void initState() { 
     super.initState();
       
     getJsondata();
  
   }
   Future<String> getJsondata()async{
     
     var response= await http.get(Uri.http('192.168.43.187:8000', '/complaints/allcomplaints/'),
     
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
     );
     setState(() {
       data=jsonDecode(response.body);
      
     });
      print(data[0]['comp_title']);

   }
  
  @override
  Widget build(BuildContext context) {
      //  final titles=['Title1', 'Title2','Title3'];
    return ListView.builder(
    itemCount:data==null? 0 :data.length,
    itemBuilder:(context,index) {
      return ExpansionTile(
   
   title: Text(data[index]['comp_title'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
   ),
   children: [
     Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Title :",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
        Expanded(child:  Text(data[index]['comp_title']))
       ],
     ),
     SizedBox(height:20),
 Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Complaint Date :",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width:20),
         Text(data[index]['comp_date'])
       ],
     ),
      SizedBox(height:10),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Description:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
        Container(
          padding: EdgeInsets.only(top:20),
          width:150,
          child : Text(data[index]['comp_desc'], overflow: TextOverflow.ellipsis,maxLines: 5,textAlign: TextAlign.justify,),)
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Progress:",style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(width:20),
         Text(data[index]['progress'].toString())
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Status:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
         Text(data[index]['status'])
       ],
     ),
     SizedBox(height:20),

 ],
 );
    },
  );

  }
}