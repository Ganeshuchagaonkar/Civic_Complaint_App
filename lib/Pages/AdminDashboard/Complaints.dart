import 'dart:convert';
import 'dart:io';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Complaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}
var complaintsdata;

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
 complaintsdata=jsonDecode(res.body);
 

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
                  'Users',
                ),
                 onTap: (){
                  Navigator.pushNamed(context, '/Admin/citizen');
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
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
    itemCount:complaintsdata.length,
    itemBuilder:(context,index) {
      return Card(child:ExpansionTile(
   
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
//      TextButton(
//         style: TextButton.styleFrom(
//                        backgroundColor: Colors.purple[900],
//                         primary: Colors.white,
//                         onSurface: Colors.grey),
//        onPressed: (){
//          return showDialog(
// context:context,
// builder:(BuildContext context){
//   return Dialog(
//     shape: RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.circular(20.0)),

//           child: Container(
//             height: 200,
           
//             child: Padding(
//               padding: const EdgeInsets.only(top:30,left: 20,),
//               child: SingleChildScrollView(
//                               child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//                       TextField(
//                         keyboardType: TextInputType.text,
//                         maxLines: 2,
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Enter Message'),
//                       ),
                      
                     
//                        TextButton(
//                         style: TextButton.styleFrom(
//                        backgroundColor: Colors.purple[900],
//                         primary: Colors.white,
//                         onSurface: Colors.grey),
//                          onPressed:(){

//                        }, child: Text('Submit',style: TextStyle(color: Colors.white,backgroundColor:  Colors.purple[900],),))

//             ],
//           ),
//               ),),)

//   );
// }
//          );
//        }, child: Text('Notify Officer',))


    ],),),
 ],
 ));
 
    },
  );
  }
}