import 'package:civic_app/Pages/AdminDashboard/Addofficer.dart';

import 'package:civic_app/Pages/AdminDashboard/Complaints.dart';
import 'package:civic_app/Pages/AdminDashboard/AdminHomePage.dart';

import 'package:civic_app/Pages/AdminDashboard/Removeofficer.dart';
import 'package:civic_app/Pages/Citizen_DashBoard_Pages/Add_Complaints.dart';
import 'package:civic_app/Pages/Citizen_DashBoard_Pages/LatestComplaints.dart';
import 'package:civic_app/Pages/Citizen_DashBoard_Pages/Profile.dart';
import 'package:civic_app/Pages/Citizen_DashBoard_Pages/ViewComplaints.dart';
import 'package:civic_app/Pages/OfficerDashboard/Allcomplaints.dart';
import 'package:civic_app/Pages/OfficerDashboard/OfficerDashboard.dart';
import 'package:civic_app/Pages/OfficerDashboard/PendingComplaints.dart';
import 'package:civic_app/Pages/OfficerDashboard/Profile.dart';
import 'package:civic_app/Pages/OfficerDashboard/ResolvedComplaints.dart';
import 'package:civic_app/Pages/OfficerDashboard/UpdateComplaint.dart';
import 'package:civic_app/Signup.dart';
import 'package:civic_app/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/login': (context) => Login(),

          //citizen routes
          '/citizenDashboard/profile': (context) => Profile(),
          '/citizenDashboard/AddComplaints': (context) => Add_Complaints(),
          '/citizenDashboard/ViewComplaints': (context) => ViewComplaints(),
          '/citizenDashboard': (context) => LatestComplaints(),

          //officer Dashboard routes
          '/officerDashboard': (context) => OfficerDashboard(),
          '/officerDashboard/profile': (context) => OfficerProfile(),
          '/officerDashboard/Pendingcomplaint': (context) => PendingIssue(),
          '/officerDashboard/Resolvedcomplaint': (context) => ResolvedIssue(),
          '/updatecomplaint':(context) =>UpdateComplaint(),
          '/officerDashboard/AllComplaints': (context) => AllComplaints(),

          //AdminDashboard Routes
          '/Admin/Home': (context) => AdminHome(),
    
          '/Admin/addofficer': (context) => Addofficer(),
          '/Admin/removeofficer': (context) => Removeofficer(),
          '/Admin/Complaints': (context) => Complaints(),
          
        },
        theme: ThemeData(),
        home:Login());
  }
}






