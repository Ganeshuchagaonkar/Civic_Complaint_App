import 'dart:convert';
import 'dart:io';
import 'package:civic_app/Resusable_Component/DisplayMap.dart';
import 'package:flutter_vlc_player/generated/i18n.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:geocoder/geocoder.dart';

class Complaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}
List complaintsdata;

class _ComplaintsState extends State<Complaints> {
  @override
  @override
  void initState() { 
    super.initState();
    getComplaints();
  }
  void getComplaints()async{

var res=await http.get(Uri.http("192.168.43.187:8000", "complaints/allcomplaints"),headers: <String,String>{
  'Content-Type':'application/jsone;  charset=UTF-8'
});

setState(() {
   complaintsdata=jsonDecode(res.body);
   print(complaintsdata);
});
 

  }
   
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.purple[900],
       title: Text('Complaints'),),

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
                  Navigator.pushNamed(context, '/Admin/removeofficer');
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
       body:  Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child:ComplaintView(),
              ),
            ]
        ),
        ),
        
      ),
    );
  }
}

class ComplaintView extends StatefulWidget {
  @override
  _ComplaintViewState createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
    VlcPlayerController _vlcViewController;
    String streamurl;
    @override
    void initState() { 
      super.initState();
    
       _vlcViewController = new VlcPlayerController();
       
       
     
    }
    @override
      void dispose() {
      super.dispose();
        _vlcViewController.dispose();
      }   // TODO: implement dispose
       
// _stream(){
//   setState(() {
//       streamurl='http://192.168.43.187:8000/media/videos/1571548439460.mp4';
//     });
// }
Future getLatLang() async {
    // From a query
    final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DisplayMap(
            latitude: first.coordinates.latitude,
            longitude: first.coordinates.longitude)));
  }
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
    itemCount:complaintsdata.length,
    itemBuilder:(context,index) {
      return complaintsdata!=null ? Card(child:ExpansionTile(
   
   title: Text(complaintsdata[index]['comp_title'],style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
   
   ),
   children: [
    Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
       Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Title :",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
         Text(complaintsdata[index]['comp_title'].toString())
       ],
     ),
     SizedBox(height:20),
 Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Complaint Date :",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width:20),
         Text(complaintsdata[index]['comp_date'])
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Action Take:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
        
        
           Text(complaintsdata[index]['action_taken'], overflow: TextOverflow.ellipsis,maxLines: 10,textAlign: TextAlign.justify,),
       ],
     ),
     
     SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Address:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
        
        
           Text(complaintsdata[index]['address'], overflow: TextOverflow.ellipsis,maxLines: 10,textAlign: TextAlign.justify,),
       ],
     ),
     SizedBox(height: 20,),
     Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Location:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
           TextButton
           ( 
             onPressed:(){
    getLatLang();
           }, 
           
           child: Text("Click here view the location"))
        
           ],
     ),
      SizedBox(height:20),
     Row(
       children: [
          Text("Image",style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width:5),
     
      Image.network('http://192.168.43.187:8000'+complaintsdata[4]['comp_image'],width: 250,height: 120,),
       ],
     ),
       SizedBox(height:20),
       Text("Video",style: TextStyle(fontWeight: FontWeight.bold)),
           SizedBox(height: 20,),
       streamurl!=null? Container(child: new VlcPlayer(
        defaultHeight: 480,
        defaultWidth: 640,
        controller: _vlcViewController,
      
       url:streamurl,
        placeholder: Container(),
        ),):Text('click play button to play the video'),
        SizedBox(height:5),
        FloatingActionButton(
          backgroundColor: Colors.purple[900],
          child:Icon(streamurl==null?Icons.play_arrow:Icons.pause),
          onPressed: (){
        setState(() {
                  if(streamurl==null){
                    streamurl="http://192.168.43.187:8000"+complaintsdata[index]['comp_video'];
                    // _vlcViewController.dispose();
                  }
                  else{
                    streamurl=null;
                  }
                }
                );
                
        }
        ),
          SizedBox(height:20),



    ],),),
 ],
 )):
  CircularProgressIndicator(
    
  );
 
    },
  );
  }
}