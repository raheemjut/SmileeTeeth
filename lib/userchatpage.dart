//@dart=2.9
import 'dart:async';
import 'dart:convert';


import 'package:finalproject/Chatpage.dart';
import 'package:finalproject/Config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Spacecraft {
  final String id;
  final String username, email;

  Spacecraft({
    this.id,
    this.username,
    this.email,
  });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      id: jsonData['id'],
      username: jsonData['username'],
      email: jsonData['email'],
    );
  }
}


class AgentsChatsPage extends StatefulWidget {


  @override
  _AgentsChatsPageState createState() => _AgentsChatsPageState();
}

class _AgentsChatsPageState extends State<AgentsChatsPage> {
String loginusername = "", loginemail = "", loginpicture = "";
  void getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginusername = sharedPreferences.getString("username");
      loginemail = sharedPreferences.getString("email");
      
      print(loginusername);
    });
  }

  List<Spacecraft> orders = List();
  List<Spacecraft> filteredorders = List();
 
  bool loading = true;
  bool searchapp = false;
  bool iconsearch = true;
  Future<List<Spacecraft>> downloadJSON() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response =
      await http.post(ApiUrls.fetchchatdoctors + "?nochache=1", body: {
      
    });
    //final response = await get(jsonEndpoint);
    //print(response.body);
    if (response.statusCode == 200) {
      List spacecrafts = json.decode(response.body);
      return spacecrafts
          .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
          .toList();
    } else
      throw Exception(
          'We were not able to successfully download the json data.');
  }

  @override
  void initState() {
    
    super.initState();
    getUser();
    downloadJSON().then((usersfromserver) {
      setState(() {
        orders = usersfromserver;
        filteredorders = orders;
        loading = false;
      });
    });
      
  }

  @override
  Widget build(BuildContext context) => Scaffold(

     appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
        title: Text('Chat'),
        centerTitle: true,
      ),
          body: Column(children: <Widget>[
       
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: filteredorders.length,
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                    contentPadding: new EdgeInsets.only(left: 0, right: 10),
                    title: GestureDetector(
                        onTap: () {
                          print("helo");
                          // slideESheet(spacecraft.id, spacecraft.productid, spacecraft.dailysale, spacecraft.overallsale);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => ChatPage(user: user),
                                  // ));
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      receiverid:
                                          filteredorders[index].username,
                                      phonenumber:
                                          filteredorders[index].email,
                                    ),
                                  ));
                                },
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage("assets/images/logo2.png"),
                                ),
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Dr. "+filteredorders[index].username),
                                    // Container(
                                    //   height: 30,
                                    //   width: 30,
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.green,
                                    //       borderRadius:
                                    //           BorderRadius.circular(50)),
                                    //   child: Center(
                                    //       child: Text(
                                    //     old,
                                    //     style: GoogleFonts.ubuntu(
                                    //         color: Colors.white),
                                    //   )),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            )
                          ],
                        )),
                  );
                }))
      ])

          // SafeArea(

          // child:Center(
          //  //FutureBuilder is a widget that builds itself based on the latest snapshot
          //  // of interaction with a Future.
          //  child: new FutureBuilder<List<Spacecraft>>(
          //    future: downloadJSON(),
          //    //we pass a BuildContext and an AsyncSnapshot object which is an
          //    //Immutable representation of the most recent interaction with
          //    //an asynchronous computation.
          //    builder: (context, snapshot) {
          //      if (snapshot.hasData) {
          //        List<Spacecraft> spacecrafts = snapshot.data;
          //        return new CustomListView(spacecrafts);
          //      } else if (snapshot.hasError) {
          //        return Text("No Seller available");
          //      }
          //      //return  a circular progress indicator.
          //      return new CircularProgressIndicator();
          //    },
          //  ),

          //   ),
          // ),

          );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
