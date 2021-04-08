import 'package:blood_donor/Application/models/appointments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleAppointment extends StatefulWidget {
  ScheduleAppointment({Key key}) : super(key: key);

  @override
  _ScheduleAppointmentState createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  DateTime tdate;
  DateTime ttime;
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  String _bloodtype = 'O negative';

  Future<Function> _scheduleAppointment(
      String name,
      String email,
      String phone,
      String address,
      User user,
      String bloodType,
      DateTime day,
      DateTime time) async {
    Appointment appointment = new Appointment(
        name: name,
        acknowledged: false,
        email: email,
        phone: phone,
        address: address,
        user_name: user.displayName,
        user_id: user.uid,
        bloodType: bloodType,
        day: day,
        time: time,
        timestamp: DateTime.now(),
        done: false);
    await FirebaseFirestore.instance
        .collection("appointments")
        .doc(user.uid)
        .set({
      "name": appointment.name,
      "email": appointment.email,
      "phone": appointment.phone,
      "acknowledged": appointment.acknowledged,
      "address": appointment.address,
      "user_id": appointment.user_id,
      "done": appointment.done,
      "user_name": appointment.user_name,
      "bloodType": appointment.bloodType,
      "day": appointment.day,
      "time": appointment.time,
      "timestamp": appointment.timestamp
    });
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user != null) {
      _name.text = user.displayName;
      _email.text = user.email;
      _phoneNumber.text = user.phoneNumber;
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text("Schedule Donation"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: !isloading
              ? Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    if (user == null) ...[
                      Center(
                        child: Text(
                            "Kindly note, in oder to track your donations and gain points you must LogIn.!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(
                                fontSize: 10, color: Colors.red)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                    Center(
                      child: Text("Schedule a Donation",
                          style: GoogleFonts.mcLaren(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      elevation: 2,
                      child: Image.asset(
                        "assets/images/img1.png",
                        height: 150,
                        fit: BoxFit.fitWidth,
                        width: width * .8,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            "Pick A date and Time you want us to come to you, and tell us a little about yourself",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
//                        maxTime: DateTime(2019, 6, 7),
                              theme: DatePickerTheme(
                                  headerColor: Colors.redAccent,
                                  backgroundColor: Colors.blue,
                                  itemStyle: GoogleFonts.mcLaren(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16)), onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            setState(() {
                              tdate = date.toLocal();
                            });
                            print('the new date $tdate');
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        color: Colors.redAccent,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: width * .75,
                            child: Center(
                              child: Text(
                                "Pick A Date",
                                style: GoogleFonts.mcLaren(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            "Date of appointment Set to:  ${tdate != null ? DateFormat("MMMM d yyy").format(tdate) : DateFormat("MMMM d yyy").format(DateTime.now().add(Duration(days: 1)))}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            setState(() {
                              ttime = date;
                            });
                            print('confirm $date');
                          }, currentTime: DateTime.now());
                        },
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: width * .75,
                            child: Center(
                              child: Text(
                                "Pick A Time",
                                style: GoogleFonts.mcLaren(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            "Time of appointment Set to:  ${ttime != null ? DateFormat.Hm().format(ttime) : DateFormat.Hm().format(DateTime.now().add(Duration(hours: 2)))}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Tell us How can we reach you below",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Full Name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: new TextFormField(
                        controller: _name,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: "enter your name here...",
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.redAccent,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                            ),
                            border: UnderlineInputBorder()),
                        obscureText: false,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Phone Number",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: new TextFormField(
                        controller: _phoneNumber,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: "phone number...",
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.redAccent,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                            ),
                            border: UnderlineInputBorder()),
                        obscureText: false,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Location Address",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: new TextFormField(
                        controller: _address,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        decoration: InputDecoration(
                            hintText: "enter home address here...",
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.redAccent,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                            ),
                            border: UnderlineInputBorder()),
                        obscureText: false,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Blood type",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mcLaren(fontSize: 20)),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.water_damage_rounded),
                      title: new DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        value: _bloodtype,
                        items: <String>[
                          'O negative',
                          'O positive',
                          'A negative',
                          'A positive',
                          'B negative',
                          'B positive',
                          'AB negative',
                          'AB positive',
                          'Not to Sure'
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mcLaren(fontSize: 20)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _bloodtype = newValue;
                          });
                        },
                      )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            isloading = true;
                          });
                          _scheduleAppointment(
                                  _name.text,
                                  _email.text,
                                  _phoneNumber.text,
                                  _address.text,
                                  user,
                                  _bloodtype,
                                  tdate,
                                  ttime)
                              .then((value) {
                            setState(() {
                              isloading = false;
                            });
                            Fluttertoast.showToast(
                                msg:
                                    "Appointment Booked for ${DateFormat("MMMM d yyy").format(tdate)} at ${DateFormat.Hm().format(ttime)} !!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.green,
                                fontSize: 16.0);
                          }).catchError((e) {
                            Fluttertoast.showToast(
                                msg: "${e.toString()}",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.red,
                                fontSize: 16.0);
                          });
                        },
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: width * .75,
                            child: Center(
                              child: Text(
                                "Schedule Appointment ",
                                style: GoogleFonts.mcLaren(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: height * .4),
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
