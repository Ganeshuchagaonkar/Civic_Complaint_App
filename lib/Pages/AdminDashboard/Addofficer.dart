import 'package:flutter/material.dart';
import 'package:civic_app/Resusable_Component/btn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Addofficer extends StatefulWidget {
  @override
  _AddofficerState createState() => _AddofficerState();
}

class _AddofficerState extends State<Addofficer> {
   bool  _obscureText;
  @override
void initState() { 
  super.initState();
  _obscureText=false;
  getStates();
  
}

   int statevalue;
  int cityvalue;
  List newstates=[];
  List cities=[];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  
  void submitOfficerDetails(String name ,String email, int phone,String password)async{
   
    var jsonbody=jsonEncode({"name":name,"email":email,"phone":phone,"password":password,"country":"India","role":"officer","state_id":statevalue.toInt(),"city_id":cityvalue.toInt()});
  var response=await http.post(Uri.http("192.168.43.187:8000", "users/adduser/")
  ,body: jsonbody,headers: <String,String>{
    'Content-Type':'application/json; charset=UTF-8',
  }
  );
  var data=jsonDecode(response.body);
  print(data);
  if(data['status']==1){
       
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("New officer added Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
         
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
    
  }
  }
  //Api request to get States
  Future<String> getStates() async {
    
    print("getstates");
    var response = await http.get(
      Uri.http("192.168.43.187:8000", "statecity/states/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );


    setState(() {
      newstates = jsonDecode(response.body);
    });
    return null;
  }
 //Api request to get cities 
   Future <String> getcities( int state_id )async{
    String endpoint="statecity/cities/$state_id/";
    print(endpoint);
    var res= await http.get(Uri.http("192.168.43.187:8000", endpoint));
    setState(() {
     cities =jsonDecode(res.body);
    });

    return null;
    
  } 
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Add Officers'),
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:30),
              Text('Add officer',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
              SizedBox(height:40),
        
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
                          controller: _nameController,
                          keyboardType: TextInputType.text,

                          decoration: const InputDecoration(
                            
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter you name',
                             
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      SizedBox(height:30),
                      Material(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: TextFormField(
                      
                          validator: validateEmail,
                          controller: _emailController,
                          keyboardType: TextInputType.text,

                          decoration: const InputDecoration(
                            
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                           
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Email',
                            
                             
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(height:30),
                      Material(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: TextFormField(
                          validator: validateMobile,
                          controller: _phoneController,
                          keyboardType: TextInputType.text,

                          decoration: const InputDecoration(
                            
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Mobile',
                             
                            labelText: 'Mobile',
                          ),
                        ),
                      ),
                      SizedBox(height:30),
                     Row(
                        children: [
                        Expanded(child:   Material(
                           elevation: 5,
                        shadowColor: Colors.grey,
                            child: TextFormField(
                          
                         
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          initialValue: 'officer',

                          decoration: const InputDecoration(
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            
                          
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                          
                            
                            
                          ),
                        ),
                          ),),
                          SizedBox(width:20),
                           Expanded(child:   Material(
                               elevation: 5,
                        shadowColor: Colors.grey,
                            child: TextFormField(
                         
                          
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          initialValue: 'India',

                          decoration: const InputDecoration(
                             contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                         
                          
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                         
                          ),
                        ),
                          ),)
                          
                        ],
                      ),
                      SizedBox(height:30),
                      Row(
                        children: [
                        Expanded(child:   Material(
                         elevation: 5,
                        shadowColor: Colors.grey,
                        child: DropdownButtonFormField(
                          
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 16, 10, 16),
                            border: InputBorder.none,
                            filled: true,
                            
                            
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Choose state",
                            fillColor: Colors.white,
                          ),
                          value: statevalue,
                          onChanged: (var ele){
                            setState(() {
                              statevalue=ele;
                              getcities(statevalue);
                            });
                          },
                          
                          items: newstates
                              .map((ele) => DropdownMenuItem(
                                  value: ele['state_id'], child: Text(ele['state_name'])))
                              .toList(),
                        ),
                      ),
                          ),
                          SizedBox(width:20),
                                             Expanded(
                        child: Material(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 16, 10, 16),
                              border: InputBorder.none,
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Choose city",
                              fillColor: Colors.white,
                            ),
                            value: cityvalue,
                            onChanged: (var ele) {
                              setState(() {
                                cityvalue = ele;
                              
                              });
                            },
                            items: cities
                                .map((item) => DropdownMenuItem(
                                    value: item['city_id'], child: Text(item['city_name'])))
                                .toList(),
                          ),
                        ),
                      )

                       ],   
                      ),
                      SizedBox(height:30),
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
                          
                          keyboardType: TextInputType.text,
                          obscureText: _obscureText,
                          
                         controller:_passController,
                          decoration: const InputDecoration(
                            
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            
                          
                            border: InputBorder.none,
                            // suffixIcon: IconButton(icon:Icon(_obscureText? Icons.visibility :Icons.visibility_off), onPressed: onPressed),
        //                     suffixIcon: new GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       _obscureText = !_obscureText;
        //     });
        //   },
        //   child:
        //   new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        // ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'password',
                             hintStyle: TextStyle(color: Colors.grey),
                            labelText: 'password',
                          ),
                        ),
                      ),
                      SizedBox(height:40),
                     Btn(
                       text:"Submit",
                       onPress: (){
                         print("clicked");
                        String name=_nameController.text;
                        String email=_emailController.text;
                        int phone=int.parse(_phoneController.text);
                        String password=_passController.text;
                        print(phone);
                        submitOfficerDetails(name,email,phone,password);
                       },
                     )
            ],
          ),
        )),
      ),
    );
  }
}
