import 'package:blood_donor/Presentation/time_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DonationHistory extends StatefulWidget {
  DonationHistory({Key key}) : super(key: key);

  @override
  _DonnationHistoryState createState() => _DonnationHistoryState();
}

class _DonnationHistoryState extends State<DonationHistory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:
        Text("Donation History", style: GoogleFonts.mcLaren(fontSize: 15)),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text("Total Donations",
                  style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                color: Colors.grey[100],
                child: ListTile(
                  leading: Icon(
                    Icons.water_damage_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                  title:  Text("2 Donations Made so far", style: GoogleFonts.mcLaren(fontSize: 15)),
                  subtitle:  Text("Blood", style: GoogleFonts.mcLaren(fontSize: 10)),
                ),
              ),
            ),
            Center(
              child: Container(
                width: width * .8,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text("Your last Donation was",
                  style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text("${DateFormat("MMMM d yyy").format(DateTime.now().subtract(Duration(days: 1)))}",
                  style: GoogleFonts.mcLaren(fontSize: 13, color: Colors.grey)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                color: Colors.grey[100],
                child: ListTile(
                  leading: Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                  title:  Text("2 Gallons Donated", style: GoogleFonts.mcLaren(fontSize: 15)),
                  subtitle:  Text("1 Unit (8 points)", style: GoogleFonts.mcLaren(fontSize: 10)),
                ),
              ),
            ),
            Center(
              child: Container(
                width: width * .8,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text("Your Donation Journey",
                  style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.black)),
            ),
            SizedBox(
              height: 30,
            ),
            TimeLine(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}