import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config.dart';
class TermsandCondition extends StatefulWidget {
  @override
  _TermsandConditionState createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
  String data = '';
 fetchFileDate()async{
   String responsetext;
   responsetext = await rootBundle.loadString('assets/images/privacy.txt');
  setState(() {
    data = responsetext;
  });
 }
 @override
  void initState() {
    // TODO: implement initState
     fetchFileDate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
       return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: Text("TERMS & CONDITIONS"),centerTitle: true,
          backgroundColor:Colors.deepPurple,
          
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
            height: 110,
          //  width: 50,
          color: Colors.white,
            child: Image.asset("assets/images/logo.png", scale: 1.0,)),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  children: <Widget>[
                    
                    Expanded(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: new EdgeInsets.only(top: 3.0),
                          child: Text(
                            'Medical Emergency & Pharma \nTerms & Conditions',
                            style: GoogleFonts.raleway(
                              color:  Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                
                     SizedBox(
            width: double.infinity,
            // height: double.infinity,
            child:   Container(
              margin: new EdgeInsets.all(10),
              child: Text(data,
                style: GoogleFonts.lora(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400
                
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
              ],
            )
          ],
        ));
  
  }
}