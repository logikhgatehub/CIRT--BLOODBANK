import 'package:blood_donor/Application/models/articles.dart';
import 'package:blood_donor/Application/reposotory/rep.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<ArticlesPage> {
  Stream<List<Articles>> _articlesStream;

  @override
  void initState() {
    super.initState();
    _articlesStream = context.read<Repository>().getArticles();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Latest Articles", style: GoogleFonts.mcLaren(fontSize: 15)),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            StreamBuilder<List<Articles>>(
              stream: _articlesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Articles>> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Column(
                      children: [
                        SizedBox(
                          height: height * .4,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    );
                  default:
                    if(snapshot.data.isEmpty){
                      return Column(
                        children: [
                          SizedBox(
                            height: height * .3,
                          ),
                          Center(
                            child: Text("No Articles found...", style: GoogleFonts.mcLaren(fontSize: 15)),
                          )
                        ],
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data.map((Articles articles) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(articles.title,style: GoogleFonts.mcLaren(fontSize: 15)),
                                ),
                                subtitle: Text(articles.content,style: GoogleFonts.mcLaren(fontSize: 12)),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
