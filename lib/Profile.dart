import 'dart:convert';
import 'dart:io';

import 'package:finalproject/Config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final descriptionController = new TextEditingController();
  final usernameController = new TextEditingController();
  final emailController = new TextEditingController();
  final phoneController = new TextEditingController();
  File uploadimageproduct = new File("");
  Future<void> cameraImageCamera() async {
    var choosedimage = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimageproduct = choosedimage;
    });
  }

  Future<void> chooseImageGallery() async {
    try {
      var choosedimage = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      //set source: ImageSource.camera to get image from camera
      setState(() {
        uploadimageproduct = choosedimage;
      });
    } catch (e) {
      print("gallery not responding");
    }
  }

  String loginusername = "", loginemail = "", loginpicture = "";
  void getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginusername = sharedPreferences.getString("username")!;
      loginemail = sharedPreferences.getString("email")!;
      usernameController.text = loginusername;
      emailController.text = loginemail;
      print(loginusername);
    });
  }

  bool isloading = true;
  Future<List> fetchUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await http.post(ApiUrls.fetchUser, body: {
      //  "cnic": cniccontroller.text,
      "email": sharedPreferences.getString("email"),
    });
    var message = jsonDecode(response.body);
    print(message);
    var arr = message.split('*');
    if (arr[0] == "exists") {
      if (response.statusCode == 200) {
        setState(() {
          phoneController.text = arr[3];
          loginpicture = arr[1];
          descriptionController.text = arr[2];
          isloading = false;
        });
      }
    }
    return message;
  }

  void showMessage(String message, Color bgclrvalue, Color txtclrvalue) {
    Toast.show(
      message,
      context,
      backgroundRadius: 0,
      backgroundColor: bgclrvalue,
      textColor: txtclrvalue,
      duration: Toast.LENGTH_SHORT,
    );
  }

  Future<void> uploadImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      List<int> imageBytesproduct = uploadimageproduct.readAsBytesSync();
      String baseimageproduct = base64Encode(imageBytesproduct);

      //convert file image to Base64 encoding

      var response = await http.post(ApiUrls.updateUser, body: {
        'image': baseimageproduct,
        'email': sharedPreferences.getString("email"),
        'bio': descriptionController.text
      });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        print(jsondata);
        if (jsondata["error"]) {
          print(jsondata["msg"]);
        } else {
          print(jsondata["msg"]);
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Profile()));
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print("Error during converting to Base64");
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: isloading
          ? Center(child: new CircularProgressIndicator())
          : Stack(
              children: [
                ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: loginpicture == "N/A"
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png'))
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        ApiUrls.imagepath + loginpicture),
                                  )),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                    onPressed: cameraImageCamera,
                                    iconSize: 40.0,
                                    icon: new Icon(
                                      Icons.photo_camera,
                                      color: Colors.black,
                                    )),
                                IconButton(
                                    iconSize: 40.0,
                                    onPressed: chooseImageGallery,
                                    icon: new Icon(
                                      Icons.image,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 310),
                          child: Text(
                            'Name',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 350,
                          child: TextField(
                              controller: usernameController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'ABCD___',
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 310),
                          child: Text(
                            'Email',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 350,
                          child: TextField(
                              controller: emailController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'abc___@__.com',
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 250),
                          child: Text(
                            'Phone Number',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 350,
                          child: TextField(
                              controller: phoneController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: '03** *******',
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: Text(
                            'Address & Description',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          width: 350,
                          child: TextField(
                              controller: descriptionController,
                              maxLength: 100,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Tell about youself',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200, top: 10),
                          child: InkWell(
                            onTap: () {
                              uploadImage();
                            
                            },
                            child: Container(
                              height: 60,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 10),
                                  child: Icon(Icons.update,
                                      color: Colors.white, size: 25),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
    );
  }
}
