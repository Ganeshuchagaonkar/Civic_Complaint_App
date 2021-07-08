import 'dart:convert';
import 'package:civic_app/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:civic_app/Pages/AdminDashboard/AdminHomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:civic_app/Resusable_Component/Btn.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
   @override
void initState() { 
  super.initState();
  //  _getState();
}

  String token;  
  String dropDownValue;
  List<String> userType = ['Admin', 'Officer','user'];


  void verifylogin(String email, String pass)async{
    var jsondata=jsonEncode({
      "email":email,
      "password":pass,
    });


    var response= await http.post(Uri.http("192.168.43.187:8000","users/api/token/"),body: jsondata, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
      final data=jsonDecode(response.body);
      
    print(data);
      if(data['role']=="citizen")
      { 
        
         Navigator.pushNamed(context, '/citizenDashboard');
          SharedPreferences prefs=await SharedPreferences.getInstance();
           prefs.setString("Refreshtoken",data['refresh']);
           prefs.setString("Accesstoken", data['access']);
           prefs.setString("username", data['name']);
           prefs.setString("citizenemail", data['email']);
           prefs.setInt("citizenphone", data['phone']);
           prefs.setString("citizencountry",data["country"]);
           prefs.setString("citizenState", data['state']);
           prefs.setString("citizenCity", data['city']);
           prefs.setInt("userid", data['user_id']);
           prefs.setInt("city",data['city_id']);
           prefs.setInt("state", data['state_id']);
           
          
           
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("Loged in Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
       
      }
      
      
      else if(data['role']=="admin"){
       
        Navigator.pushNamed(context, '/Admin/Home');
        
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("Loged in Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
           }
      else if(data['role']=="officer"){
      
        final SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setString("officername", data['name']);
        prefs.setString("officeremail", data['email']);
        prefs.setInt("officerMobile", data['phone']);
        prefs.setString("officercountry", data['country']);
        prefs.setString("officerstate", data['state']);
        prefs.setString("officercity", data['city']);
        prefs.setInt(("userid"),data['user_id']);
        Navigator.pushNamed(context, '/officerDashboard');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("Loged in Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
      }
      else{
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[300],
            content:const Text("Invalid username & Password!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
      }
      
           

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: new Container(
            padding: EdgeInsets.only(top: 40, left: 30, right: 20),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back..!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pasifico-Regular', 
                              fontSize: 30),
                        ),
                      ],
                    ),
                   
                    Image(
                      image: AssetImage('images/log3.png'),
                      width: 300,
                      height: 300,
                      
                    ),
                   
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
                          controller: _emailController,
                          keyboardType: TextInputType.text,

                          decoration: const InputDecoration(
                            
                             contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            prefixIcon: Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.black
                            ),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter Your email',
                             
                            labelText: 'Email',
                          ),
                        ),
                      ),
                    
                    SizedBox(
                      height: 20.0,
                    ),
                    
                    
                   
                    // Material(
                    //      elevation: 5,
                    //     shadowColor: Colors.grey,
                    //     child: DropdownButtonFormField(
                          
                    //       decoration: InputDecoration(
                    //         contentPadding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                    //         border: InputBorder.none,
                    //         filled: true,
                    //          prefixIcon: Icon(
                    //           Icons.arrow_downward_rounded,
                    //           size: 25,
                    //           color: Colors.black
                    //         ),
                            
                    //         hintStyle: TextStyle(color: Colors.grey),
                    //         hintText: "Choose UserType",
                    //         fillColor: Colors.white,
                    //       ),
                    //       value: dropDownValue,
                    //       onChanged: (String value) {
                    //         setState(() {
                    //           dropDownValue = value;
                    //         });
                    //       },
                    //       items: userType
                    //           .map((item) => DropdownMenuItem(
                    //               value: item, child: Text("$item")))
                    //           .toList(),
                    //     ),
                    //   ),
                      SizedBox(
                      height: 20.0,
                    ),
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
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
obscureText: true,
                          decoration: const InputDecoration(
                             contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 20,
                              color: Colors.black,
                            ),
                          
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'password',
                             hintStyle: TextStyle(color: Colors.grey),
                            labelText: 'password',
                          ),
                        ),
                      ),
                     SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "forgot password?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    
                    SizedBox(height: 25),
                    // _submitButton(),
                    Btn(
                      text:"Login",
                     onPress: (){
                       String email= _emailController.text;
                       String pass=_passwordController.text;
                       verifylogin(email ,pass);
                     },

                      
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text("Don't have an account?"),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>Signup() ));
                                },
                                child: Container(
                                  child: new Text(
                                    "SIGN UP",
                                    style: TextStyle(color: Colors.purple[900],fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Divider(color:Colors.black ,height: 40,)
                  ],
                ),
              ),
            )));
  }
}
