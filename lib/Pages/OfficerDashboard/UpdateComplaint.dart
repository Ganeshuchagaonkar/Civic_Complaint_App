import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateComplaint extends StatefulWidget {
  @override
  _UpdateComplaintState createState() => _UpdateComplaintState();
}

class _UpdateComplaintState extends State<UpdateComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text('Pending Issues'),
        ),
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
                Expanded(
                  child: PendingView(),
                ),
              ]),
        ));
  }
}

class PendingView extends StatefulWidget {
  @override
  _PendingViewState createState() => _PendingViewState();
}
final _formkey = GlobalKey<FormState>();
class _PendingViewState extends State<PendingView> {
  int complaint_id;
  String status;
  String action_taken;
  int progress;

  List pendingissue;
  @override
  @override
  void initState() {
    super.initState();
     pendingIssue();
  }

  void updateComplaint( String status,String action ,int progress,int compid) async {
   print(status);
   var body = jsonEncode({
   "complaint_id":compid,
   "action_taken":action,
   "status":status,
   "progress":progress });

    var res = await http.post(
        Uri.http("192.168.43.187:8000", "complaints/updatecomplaint/"),
        headers: <String, String>{
          'Content-Type': 'application/json;  charset=UTF-8'
        },body: body);

   var result = jsonDecode(res.body);
   if(result['status']==1)
   {
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("Updated Status of complaint Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));

        setState(() {
                  pendingIssue();
                });
   }
  }




  void pendingIssue() async {
    int user_id;
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
          user_id=prefs.get('userid');
        });
    var res = await http.get(
        Uri.http("192.168.43.187:8000", "complaints/pending/complaints/$user_id"),
        headers: <String, String>{
          'Content-Type': 'application/json;  charset=UTF-8'
        });
    setState(() {
          pendingissue = jsonDecode(res.body);
        });
      print(pendingissue);
  }
  int comp_id;

 final _status =TextEditingController();
 final _progress=TextEditingController();
 final _action=TextEditingController();
  Widget build(BuildContext context) {

    return pendingissue!=null? ListView.builder(
      itemCount: pendingissue.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
                title: Text(
                  pendingissue[index]['comp_title'],
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Title :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Text(pendingissue[index]['comp_title'])
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Complaint Date :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Text(pendingissue[index]['comp_date'])
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        width: 150,
                        child: Text(
                          pendingissue[index]['comp_desc'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
               Form(
                 key: _formkey,
                 child: Column(
                 children: [
                      Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: Visibility(
                      visible: false,
                      child: TextFormField(
                        onSaved: (value)=>{
                          comp_id =pendingissue[index]['comp_id']
                        },
                        controller: TextEditingController(text: pendingissue[index]['comp_id'].toString()),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'comp_id',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      controller: _status,
                      keyboardType: TextInputType.text,
                      onChanged: (String val){
                        setState(() {
                                                  
                       });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is Required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Status',
                        
                      ),
                    ),
                  ),
                 
                  SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      controller: _progress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is Required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'progress',
                      ),
                    ),
                  ),
                
                  SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      controller: _action,
                      validator:(value) {
                        if (value.isEmpty) {
                          return "This field is Required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Action',
                      ),
                    ),
                  ),

                  SizedBox(),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.purple[900]

                    ),
                    onPressed:(){
                    if(_formkey.currentState.validate()){
                     
                    String status=_status.text;
                    String action=_action.text;
                    int progress=int.parse(_progress.text);
                    int complaint_id = pendingissue[index]['comp_id'];
                    updateComplaint(status,action,progress,complaint_id);

                    }  
                    
                  }, child: Text('update'),)
                 ],
               ))
                
                ],
              );
             
      },
    ):
    Center(
      child: Text("No issues to update"),
    );
  }
}
