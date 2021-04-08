import 'package:blood_donor/Application/googleAuth.dart';
import 'package:blood_donor/Application/models/appointments.dart';
import 'package:blood_donor/Presentation/articles.dart';
import 'package:blood_donor/Presentation/clock.dart';
import 'package:blood_donor/Presentation/schedule_appointment.dart';
import 'package:blood_donor/Presentation/settings_page.dart';
import 'package:blood_donor/Presentation/time_line.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'donnation_history.dart';
import 'donor_card.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<Appointment> _appointment;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    User user = Provider.of<User>(context);
//    _appointment = context.read<Repository>().getAppointment(user.uid);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("${user.displayName}",
            style: GoogleFonts.mcLaren(fontSize: 15)),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<GoogleAuthService>().signOut();
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: width,
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage("${user.photoURL}"),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 120,
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: Text("Blood Type",
                              style: GoogleFonts.mcLaren(
                                  fontSize: 15, color: Colors.white))),
                      Expanded(
                          child: Text("OB+",
                              style: GoogleFonts.mcLaren(
                                  fontSize: 15, color: Colors.white))),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 120,
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: Text("Blood Points",
                              style: GoogleFonts.mcLaren(
                                  fontSize: 15, color: Colors.white))),
                      Expanded(
                          child: Text("150",
                              style: GoogleFonts.mcLaren(
                                  fontSize: 15, color: Colors.white))),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              color: Colors.white,
              width: width,
              height: 390,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("appointments")
                            .doc(user.uid).snapshots(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data.exists && !snapshot.data.data()['done'] ) {
                              Map<String, dynamic> document =
                                  snapshot.data.data();
                              Appointment appointment = new Appointment(
                                  name: document['name'],
                                  acknowledged: document['acknowledged'],
                                  email: document['email'],
                                  phone: document['phone'],
                                  address: document['address'],
                                  bloodType: document['bloodType'],
                                  day:DateTime.parse((document['day'].toDate().toString())),
                                  time: DateTime.parse((document['time'].toDate().toString())),
                                  timestamp: DateTime.parse((document['timestamp'].toDate().toString())),
                                  user_id: document['user_id'],
                                  user_name: document['user_name'],
                                  done: document['done']);
                              return Column(
                                children: [
                                  Center(
                                    child: Text("You Have an Appointment Scheduled for",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.mcLaren(
                                            fontSize: 18, color: Colors.black)),
                                  ),
                                  SizedBox(height: 20,),
                                  Clock(time: appointment.time, width: 250, height: 150),
                                  SizedBox(height: 20,),
                                  Center(
                                    child: Text("${DateFormat("MMMM d").format(appointment.day)}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.mcLaren(
                                            fontSize: 18, color: Colors.black)),
                                  ),
                                  if(!appointment.acknowledged)...[
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      ScheduleAppointment()));
                                        },
                                        color: Colors.redAccent,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            width: width * .75,
                                            child: Center(
                                              child: Text(
                                                "RESCHEDULE  APPOINTMENT",
                                                style:
                                                GoogleFonts.mcLaren(
                                                    color:
                                                    Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    SizedBox(height: 20,),
                                    Center(
                                      child: Text("Appointment booking approved",
                                          style: GoogleFonts.mcLaren(
                                              fontSize: 14, color: Colors.green)),
                                    ),
                                  ]
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Center(
                                    child: Text("Make a Donation.",
                                        style: GoogleFonts.mcLaren(
                                            fontSize: 18, color: Colors.black)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      height: 290,
                                      width: width * .9,
                                      color: Colors.grey[100],
                                      child: Column(
                                        children: [
                                          Text(
                                              "Each Donation can save up to three lives",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.mcLaren(
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            elevation: 2,
                                            child: Image.asset(
                                              "assets/images/child.jpg",
                                              height: 150,
                                              fit: BoxFit.fitWidth,
                                              width: width * .8,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            ScheduleAppointment()));
                                              },
                                              color: Colors.redAccent,
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Container(
                                                  width: width * .75,
                                                  child: Center(
                                                    child: Text(
                                                      "SCHEDULE  APPOINTMENT",
                                                      style:
                                                          GoogleFonts.mcLaren(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                          }

                          return Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                Text("Loading appointments..."),
                                SizedBox(
                                  height: 30,
                                ),
                                CircularProgressIndicator()
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              color: Colors.white,
              width: width * .95,
              child: ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      _scaffoldKey.currentState
                          .showBottomSheet((context) => DonorCard(
                                user: user,
                              ));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.card_membership,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      subtitle: Text("your digital donor card",
                          style: GoogleFonts.mcLaren(
                              fontSize: 13, color: Colors.grey)),
                      title: Text("Donor Card",
                          style: GoogleFonts.mcLaren(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => ArticlesPage()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      subtitle: Text("latest stories about our work",
                          style: GoogleFonts.mcLaren(
                              fontSize: 13, color: Colors.grey)),
                      title: Text("News and Articles",
                          style: GoogleFonts.mcLaren(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => DonationHistory()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.history,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      subtitle: Text("a look back at your donations",
                          style: GoogleFonts.mcLaren(
                              fontSize: 13, color: Colors.grey)),
                      title: Text("Donation History",
                          style: GoogleFonts.mcLaren(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => SettingsPage()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      subtitle: Text("Edit your information",
                          style: GoogleFonts.mcLaren(
                              fontSize: 13, color: Colors.grey)),
                      title: Text("My Information",
                          style: GoogleFonts.mcLaren(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text("Your Most Recent Donations",
                  style:
                      GoogleFonts.mcLaren(fontSize: 16, color: Colors.black)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              width: width * .95,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TimeLine(
                  isHome: true,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
