import 'package:finalproject/Admin/viewcontactus.dart';
import 'package:finalproject/Admin/viewdoctors.dart';
import 'package:finalproject/Admin/viewfeedback.dart';
import 'package:finalproject/Admin/viewpharmacy.dart';
import 'package:finalproject/Admin/viewusers.dart';
import 'package:finalproject/Login.dart';
import 'package:flutter/material.dart';
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({ Key? key }) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
   int _currentIndex = 0;
  String imageurl="";
  final List<Widget> _children = [
    ViewUsers(),
    ViewDoctors(),
    ViewPharmacy(),
    ViewContactUs(),
    ViewFeedbacks()
  ];
  void OnTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
          title: Text('Admin Panel'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                child: Icon(Icons.logout, color: Colors.white, size:30)),
            )
          ],
          ),
        
            body: _children[_currentIndex],
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            
          backgroundColor: Colors.deepPurple,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.tealAccent,
            //iconSize: 20,
            //  selectedFontSize: 10,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.perm_identity,
                    size: 30,
                  ),
                  label: 
                    "Users",
                   
                  
                  ),

              //BottomNavigationBarItem(icon: Icon(Icons.local_hospital, size: 40,), title: Text("Challenges", style: TextStyle(color: Colors.white),)),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.medication_outlined,
                    size: 30,
                  ),
                  label: 
                    "Doctors",
                    ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.medical_services_outlined,
                    size: 30,
                  ),
                  label: 
                    "Pharmacy",
                    ),
                  BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contact_page,
                    size: 30,
                  ),
                  label: 
                    "Contact Us",
                   ),
                  BottomNavigationBarItem(
                  icon: Icon(
                    Icons.feedback,
                    size: 30,
                  ),
                  label: 
                    "Feedback",
                    ),
            ],
            onTap: OnTappedBar,
            currentIndex: _currentIndex,
          ),
        ),
    );
  }
}