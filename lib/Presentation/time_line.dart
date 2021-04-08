import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class TimeLine extends StatefulWidget {
  final bool isHome;
  TimeLine({Key key, this.isHome}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    bool isHome = widget.isHome;
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        color: Colors.red,
        indicatorTheme: IndicatorThemeData(
          position: 0,
          size: 20.0,
        ),
        connectorTheme: ConnectorThemeData(
          thickness: 2.5,
        ),
      ),
//      physics: ScrollPhysics(),
//      shrinkWrap: true,
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.alternating,
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("${DateFormat("MMMM d yyy").format(DateTime.now().subtract(Duration(days: index)))}",
                      style: GoogleFonts.mcLaren(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w200)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${index+1} Gallons given",
                  style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.black)),
            ],
          ),
        ),
        itemCount: isHome != null ? (isHome ? 2 : 10) : 10,
      ),
    );
  }
}
