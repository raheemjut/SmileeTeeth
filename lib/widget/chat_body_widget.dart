
//@dart=2.9
import 'package:finalproject/model/user.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;

  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(25),
            //   topRight: Radius.circular(25),
            // ),
            
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];

          return Column(
            children: [
              Container(
                height: 70,
                
                child: ListTile(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => ChatPage(user: user),
                    // ));
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user.urlAvatar),
                  ),
                  title: Text(user.name),
                ),
                
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Divider(color: Colors.grey,
                thickness: 1,
                ),
              )
            ],
          );
        },
        itemCount: users.length,
      );
}