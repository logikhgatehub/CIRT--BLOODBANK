import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Appointment {
 final String name;
 final String email;
 final String phone;
 final String address;
 final String user_name;
 final String user_id;
 final bool done;
 final bool acknowledged;
 final String bloodType;
 final DateTime day;
 final DateTime time;
 final DateTime timestamp;

  Appointment({this.acknowledged,this.name, this.email, this.phone, this.address, this.bloodType, this.day, this.time, this.timestamp, this.user_name, this.user_id, this.done});

}
