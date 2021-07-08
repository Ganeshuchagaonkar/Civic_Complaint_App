import 'dart:convert';
import 'package:civic_app/Resusable_Component/DisplayMap.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';

class AllComplaints extends StatefulWidget {
  @override
  _AllComplaintsState createState() => _AllComplaintsState();
}

class _AllComplaintsState extends State<AllComplaints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('All Compalints'),),
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
      body:
      Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child:AllComplaintsView(),
            ),
          ]
      ),
      )
    );
  }
}

class AllComplaintsView extends StatefulWidget {
  @override
  _AllComplaintsViewState createState() => _AllComplaintsViewState();
}
List allcomplaintsdata;
class _AllComplaintsViewState extends State<AllComplaintsView> {
    VlcPlayerController _vlcViewController;
    String streamurl;
 
  @override
  void initState() { 
    super.initState();
    getallComplaints();
    _vlcViewController = new VlcPlayerController();
    
  }
   @override
   void dispose() {
      super.dispose();
        _vlcViewController.dispose();
      } 
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
  void getallComplaints()async{
    String user_id;
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
          user_id=prefs.get('userid').toString();
        });
        

var res=await http.get(Uri.http("192.168.43.187:8000", "complaints/allcomplaints/officer/$user_id"),headers: <String,String>{
  'Content-Type':'application/jsone;  charset=UTF-8'
});
setState(() {
   allcomplaintsdata=jsonDecode(res.body);
});
print(allcomplaintsdata);
  }

  Widget build(BuildContext context) {
     
    return ListView.builder(
    itemCount:allcomplaintsdata.length,
    itemBuilder:(context,index) {
      return allcomplaintsdata!=null? Card(child:  ExpansionTile(
   
   title: Text(allcomplaintsdata[index]['comp_title'] ,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500)),
  //  leading: Text(allcomplaintsdata[index]['comp_id'].toString()),
   children: [
     Container(
       padding: const EdgeInsets.all(10),
      child: Column(children: [
 Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Title :",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
         Text(allcomplaintsdata[index]['comp_title'])
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
          child : Text(allcomplaintsdata[index]['comp_desc'], overflow: TextOverflow.ellipsis,maxLines: 10,textAlign: TextAlign.justify,),)
       ],
     ),
       SizedBox(height:20),
 Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Address :",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width:20),
         Text(allcomplaintsdata[index]['address'])
       ],
     ),
     SizedBox(height:20),
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
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("State:",style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(width:20),
         Text(allcomplaintsdata[index]['state'])
       ],
     ),
      SizedBox(height:20),
      Row( mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("Image:",style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(width:20),
        Container(child:    Image(
                      image: NetworkImage('http://192.168.43.187:8000'+allcomplaintsdata[index]['comp_image']),
                      width: 250,
                      height: 150,
                      
        ),)
       ],
     ),
      
     SizedBox(height:30),
    Text("Video",style: TextStyle(fontWeight: FontWeight.bold)),
           SizedBox(height: 20,),
       streamurl!=null? Container(child: new VlcPlayer(
        defaultHeight: 480,
        defaultWidth: 640,
        controller: _vlcViewController,
        // url:"http://192.168.43.187:8000/media/videos/1571548439460.mp4",
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
                    streamurl="http://192.168.43.187:8000"+allcomplaintsdata[index]['comp_video'];
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
      ],)
     ),
    
 ],
      )
 ):
 CircularProgressIndicator();
    },
  );
  }
}