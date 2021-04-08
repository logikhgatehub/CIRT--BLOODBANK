import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonorCard extends StatelessWidget {
  final User user;

  const DonorCard({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(20), topEnd: Radius.circular(20))),
      height: height * .9,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Card(
          color: Colors.redAccent,
          elevation: 10,
          child: Container(
            height: height * .7,
            width: width * .9,
            child: Column(
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
                  child: Text("${user.displayName}",
                      style: GoogleFonts.mcLaren(
                          fontSize: 15, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Donations:",
                      style: GoogleFonts.mcLaren(
                          fontSize: 15, color: Colors.white)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 40.0,
                            child: Text("_ : _",
                                style: GoogleFonts.mcLaren(
                                    fontSize: 15, color: Colors.black)),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Text("Units",
                            style: GoogleFonts.mcLaren(
                                fontSize: 15, color: Colors.white))
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 40.0,
                            child: Text("_ : _",
                                style: GoogleFonts.mcLaren(
                                    fontSize: 15, color: Colors.black)),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Text("Gallons",
                            style: GoogleFonts.mcLaren(
                                fontSize: 15, color: Colors.white))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: width,
                  height: 1,
                  color: Colors.red,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
//                    Column(
//                      children: [
//                        Padding(
//                          padding: EdgeInsets.all(10),
//                          child: Text("_ : _",
//                              style: GoogleFonts.mcLaren(
//                                  fontSize: 15, color: Colors.black)),
//                        ),
//                        Text("Units",
//                            style: GoogleFonts.mcLaren(
//                                fontSize: 15, color: Colors.white))
//                      ],
//                    ),
//                    SizedBox(
//                      width: 50,
//                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("_ : _",
                              style: GoogleFonts.mcLaren(
                                  fontSize: 15, color: Colors.black)),
                        ),
                        Text("Blood Type",
                            style: GoogleFonts.mcLaren(
                                fontSize: 15, color: Colors.white))
                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: width * .6,
                  height: 130,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text("Approved Donor",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nanumBrushScript(
                              fontSize: 40, color: Colors.green)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
