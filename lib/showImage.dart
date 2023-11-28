//@dart =2.9
import 'package:flutter/material.dart';

import 'Config.dart';
class ShowImage extends StatefulWidget {
 final String imagelink;
  const ShowImage({Key key, this.imagelink }) : super(key: key);

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
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
        title: Text('View Order Image'),
      ),
      body:    Container(
                           
                              width: double.infinity,
                              margin: new EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                
                                image: DecorationImage(
                                  image: NetworkImage(ApiUrls.imagepath + widget.imagelink),
        fit: BoxFit.contain
                                )
                              ),
                ),
    );
  }
}