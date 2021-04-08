import 'package:blood_donor/Application/router_constants.dart';
import 'package:blood_donor/Presentation/schedule_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blood_donor/Application/googleAuth.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({Key key}) : super(key: key);

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    Future<Function> _login() async {
      await context.read<GoogleAuthService>()
          .signInWithGoogle()
          .catchError((e) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(e)));
      })
          .then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, homeRoute, (route) => false))
          .catchError((e) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(e)));
      });
    }
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child:
                  Text("Blood Donor", style: GoogleFonts.mcLaren(fontSize: 40)),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              elevation: 2,
              child: Image.asset(
                "assets/images/child.jpg",
                height: 150,
                fit: BoxFit.fitWidth,
                width: width * .8,
              ),
            ),
            Center(
              child: Padding(
                child: Text(
                  "A blood donation can help save a childs life",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mcLaren(fontSize: 20),
                ),
                padding: EdgeInsets.all(30),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => ScheduleAppointment()));
              },
              color: Colors.redAccent,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: width * .75,
                  child: Center(
                    child: Text(
                      "SCHEDULE  APPOINTMENT",
                      style: GoogleFonts.mcLaren(
                          color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                _login();
              },
              color: Colors.blueAccent,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: width * .75,
                  child: Center(
                    child: Text(
                      "LOGIN WITH GOOGLE",
                      style: GoogleFonts.mcLaren(
                          color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                child: Text(
                  "All donations are guided by a great team",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mcLaren(fontSize: 15),
                ),
                padding: EdgeInsets.all(30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
