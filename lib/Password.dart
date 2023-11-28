import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Password extends StatefulWidget {
  const Password({ Key? key }) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
        title: Text('Change Password'),
        backgroundColor: Colors.teal.shade400,
      ),
      body: Stack(
        children:[ Container(
          child:Column(
            children: [
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: Container(
                              height: 50,
                              width: 350,
                              child: TextField(
                                  decoration: InputDecoration(
                                hintText: 'Old Password',
                              )),
                            ),
               ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20),
                             child: Container(
                              height: 50,
                              width: 350,
                              child: TextField(
                                  decoration: InputDecoration(
                                hintText: 'New Password',
                              )),
                          ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20),
                             child: Container(
                              height: 50,
                              width: 350,
                              child: TextField(
                                  decoration: InputDecoration(
                                hintText: 'Confirm Password',
                              )),
                          ),
                           ),
            ],
          )
        ),
        Column(
              mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:5,bottom:5),
                  child: Container(
                    height: 50,
                    width: 380,
                    decoration: BoxDecoration(
                       color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                    ),
                   
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('CHANGE PASSWORD',style: GoogleFonts.lato(fontSize: 18,color:Colors.white,),textAlign: TextAlign.center,),
                    ),
                  ),
                )
              ],
            
          ),]
      ),
    );
    
  }
}