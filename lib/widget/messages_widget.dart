//@dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:finalproject/Config.dart';
import 'package:finalproject/model/message.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Spacecraft {
  final String id;
  final String senderphone, receiverphone,message,datetime, status;


  Spacecraft({
    this.id,
    this.senderphone,
    this.receiverphone,
    this.message,
    this.datetime,
    this.status



  });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      id: jsonData['id'],
      senderphone: jsonData['senderphone'],
      receiverphone: jsonData['receiverphone'],
      message: jsonData['message'],
      datetime: jsonData['datetime'],
      status: jsonData['status'],
     
    );
  }
}
class MessagesWidget extends StatefulWidget {
  final String idUser;
  final ValueChanged<Message> onSwipedMessage;

  const MessagesWidget({
    @required this.idUser,
    @required this.onSwipedMessage,
    Key key,
  }) : super(key: key);

  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
      String loginusername = "", loginephonenumber="";
    void getUser() async{

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        loginephonenumber = sharedPreferences.getString("phonenumber");
        loginusername = sharedPreferences.getString("username");
         
        print(loginephonenumber);
       
      });
   }
    Future<List<Spacecraft>> downloadJSON() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  

  
  final response = await http.post(
        ApiUrls.fetchchat+"?nochache=1",
        body: {
         // "phonenumber": sharedPreferences.getString("phonenumber"),
         "senderphone":sharedPreferences.getString("email"),
         "receiverphone":widget.idUser,
         
        });
  //final response = await get(jsonEndpoint);
  //print(response.body);
  if (response.statusCode == 200) {
    List spacecrafts = json.decode(response.body);
    return spacecrafts
        .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
  
   @override
  void initState() {
    // TODO:implementinitState
    super.initState();
    getUser();
    downloadJSON(); 
    Timer.periodic(Duration(seconds: 5), (timer) {
    setState(() {
downloadJSON();      
    });
        });
  }
  @override
  Widget build(BuildContext context) => FutureBuilder<List<Spacecraft>>(
        future: downloadJSON(),
        builder: (context, snapshot) {
             if (snapshot.hasData) {
               List<Spacecraft> spacecrafts = snapshot.data;
               return new CustomListView(spacecrafts);
             } else if (snapshot.hasError) {
               return Container(
                 width: double.infinity,
                 child: Center(child: Text("No Chat available")));
             }
             //return  a circular progress indicator.
             return Center(child: new CircularProgressIndicator());
           },
      
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}



class CustomListView extends StatefulWidget {
  final List<Spacecraft> spacecrafts;

  CustomListView(this.spacecrafts);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
 bool isMe;
 String myself;
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.fastOutSlowIn);
      });
      
  }
  void getUser() async{
//print(senderphone);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        myself =sharedPreferences.getString("email");
        // if(sharedPreferences.getString("phonenumber") == senderphone){
        //     isMe = true;
        // }
        // else
        // {
        //   isMe =false;
        // }
    
       
      });
   }
   int i = 1;

  Widget build(context) {
    
    return ListView.builder(
      itemCount: widget.spacecrafts.length,
      controller: _scrollController,
      shrinkWrap: true,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(widget.spacecrafts[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Spacecraft spacecraft, BuildContext context) {
getUser();
final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);
    final width = MediaQuery.of(context).size.width;
    return new Row(
      mainAxisAlignment: myself == spacecraft.senderphone  ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
      
         
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: width * 3 / 4),
            decoration: BoxDecoration(
              //color: Colors.red
              color: myself == spacecraft.senderphone ? Colors.grey[100] : Colors.green[100],
              borderRadius: myself == spacecraft.senderphone
                  ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                  : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              
              children: [

                spacecraft.status ==  "" ? 

                 Text(spacecraft.message):
                 CachedNetworkImage(
        imageUrl: ApiUrls.imagepath + spacecraft.status,
       
        errorWidget: (context, url, error) => Icon(Icons.timer),
     ),
                // Image.network(ApiUrls.imagesurl + spacecraft.status),
                 Text(
                   "\n"+ spacecraft.datetime,
                 textAlign: TextAlign.end,
                 style: GoogleFonts.lora(
                   color:Colors.blue,
                   fontSize: 10
                 ),
                 
                 )
// Text.rich(
//             TextSpan(
//               text: spacecraft.message,
//               style: GoogleFonts.lora(
//                 fontSize:12,

//               ),
              
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: "\n"+spacecraft.datetime,
                  
//                   style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.blue),
                  
                  
//                 )
//               ]
//             )
// )
               
              ],
            ),
          //  child: buildMessage(),
          ),
        ),
      ],
    );     
    
    }
    
}


  