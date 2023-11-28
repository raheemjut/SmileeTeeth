import 'package:finalproject/Doctorlogin.dart';
import 'package:finalproject/Login.dart';
import 'package:finalproject/Pharmalogin.dart';
import 'package:finalproject/Signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size= MediaQuery.of(context).size;
      height = size.height;
    width = size.width;
    return Scaffold(
      
        backgroundColor: Colors.yellow.shade200,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 90),
                child: Row(children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text('Register \nYourself',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25,)),
                      ),
                      Text('\nIn less than a minute',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600)),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 160,
                    width: 160,
                    child: Image(
                      image: AssetImage('assets/images/logo2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                 height: height/1.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signin(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                begin: Alignment.centerLeft,

                end: Alignment.centerRight,
                colors: [
                 
                  Colors.deepPurple,
                  Colors.deepPurple,
                ],
              )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Text(
                            'Patient',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pharmalogin(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                begin: Alignment.centerLeft,

                end: Alignment.centerRight,
                colors: [
                Colors.deepPurple,
                  Colors.deepPurple,
                  
                ],
              )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Text(
                            'Pharmacist',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Doctorlogin(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                         gradient: LinearGradient(
                begin: Alignment.centerLeft,

                end: Alignment.centerRight,
                colors: [
                 
                 Colors.deepPurple,
                  Colors.deepPurple
                ],
              )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Text(
                            'Doctor',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          ' Login',
                          style: GoogleFonts.ubuntu(
                              color: Colors.lightGreen, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Developed By BSCS Students'),
                     
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Haris Azhar', style: GoogleFonts.lora(
                        fontWeight: FontWeight.bold
                      ),),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Jaweria Nadir', style: GoogleFonts.lora(
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hafiz Abdul Ahad', style: GoogleFonts.lora(
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
