import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:countup/countup.dart';
import 'package:http/http.dart' as http;
class MainDashBoardPage extends StatefulWidget {
  @override
  _MainDashBoardPageState createState() => _MainDashBoardPageState();
}

class _MainDashBoardPageState extends State<MainDashBoardPage> {
  
  void initState() { 
    super.initState();
    getHomePageData(); 
  }
  @override
  var dashboardData;
  void getHomePageData()async{
  
    final response=await http.get(Uri.http("192.168.43.187:8000", "complaints/admin/home"),headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8',
    });
      setState(() {
              dashboardData=jsonDecode(response.body);
            });
     
  }
  Widget build(BuildContext context) {
    return Container(
      
          padding: EdgeInsets.only(left: 20, right: 20, top: 60),
          child:SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white
                        
                          ),
                      child: Column(
                        children: [
                          Text(
                            "Total \nComplaints",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          Countup(
                            begin: 0,
                            end: dashboardData==null?0 :dashboardData['total_complaints'].toDouble(),
                            duration: Duration(seconds: 2),
                            style: TextStyle(
                              color: Colors.purple[900],
                              fontSize: 36,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white
                       
                          ),
                      child: Column(
                        children: [
                          Text("Total Complaints\n resolved",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          Countup(
                            begin: 0,
                            end: dashboardData==null?0 :dashboardData['total_complaints_resolved'].toDouble(),
                            duration: Duration(seconds: 2),
                            style: TextStyle(
                                fontSize: 36, color: Colors.purple[900]),
                          ),
                        ],
                      ))
                ],
              ),
               SizedBox(height: 40),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white
                          
                          ),
                      child: Column(
                        children: [
                          Text(
                            "Total\nofficers",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          Countup(
                            begin: 0,
                            end:dashboardData==null?0 :dashboardData['total_officers'].toDouble(),
                            duration: Duration(seconds: 2),
                            style: TextStyle(
                              color: Colors.purple[900],
                              fontSize: 36,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white
                          
                          ),
                      child: Column(
                        children: [
                          Text("Register\n users",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          Countup(
                            begin: 0,
                            end: dashboardData==null?0 :dashboardData['total_users'].toDouble(),
                            duration: Duration(seconds: 2),
                            style: TextStyle(
                                fontSize: 36, color: Colors.purple[900]),
                          ),
                        ],
                      ))
                ],
              )
            ,SizedBox(height: 40),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white
                         
                          ),
                      child: Column(
                        children: [
                          Text(
                            "Total pending \nissues",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          Countup(
                            begin: 0,
                            end: dashboardData==null?0 :dashboardData['total_complaints_pending'].toDouble(),
                            duration: Duration(seconds: 2),
                            style: TextStyle(
                              color: Colors.purple[900],
                              fontSize: 36,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 3),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white
                          
                          ),
                      child: Column(
                        children: [
                          Text("Total cities\n connected",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          Countup(
                            begin: 0,
                            end: dashboardData==null?0 :dashboardData['total_cities'].toDouble(),
                            duration: Duration(seconds: 2),
                            style: TextStyle(
                                fontSize: 36, color: Colors.purple[900]),
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
          ),
        );
}
}