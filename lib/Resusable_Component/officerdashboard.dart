import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:countup/countup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OfficerDashBoardPage extends StatefulWidget {
  @override
  _OfficerDashBoardPageState createState() => _OfficerDashBoardPageState();
}

class _OfficerDashBoardPageState extends State<OfficerDashBoardPage> {
  

 

  void initState() {
    super.initState();
  
    getHomePageData();
  }

  @override
  var dashboardData;

  void getHomePageData() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
     int user_id;
    setState(() {
       user_id = prefs.get("userid");
    });
    print(user_id);
    final response = await http.get(
        Uri.http("192.168.43.187:8000", "complaints/officer/home/$user_id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    setState(() {
      dashboardData = jsonDecode(response.body);
    });
    print(dashboardData);
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 60),
      child: SingleChildScrollView(
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
                        color: Colors.white),
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
                          end: dashboardData == null
                              ? 0
                              : dashboardData['total_complaints'].toDouble(),
                          duration: Duration(seconds: 3),
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
                        color: Colors.white),
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
                          end: dashboardData == null
                              ? 0
                              : dashboardData['total_complaints_resolved']
                                  .toDouble(),
                          duration: Duration(seconds: 4),
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
              children: [],
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
                        color: Colors.white),
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
                          end: dashboardData == null
                              ? 0
                              : dashboardData['total_complaints_pending']
                                  .toDouble(),
                          duration: Duration(seconds: 3),
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 36,
                          ),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
