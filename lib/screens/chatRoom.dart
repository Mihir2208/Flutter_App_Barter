import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom extends StatefulWidget {
  static String id = 'chat_room';

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final msgTextController = TextEditingController();

  User loggedInUser;
  String msgText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo[300],
        title: Text('Barterers Chat Room'),
      ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blueAccent,
                        ),
                      );
                    }
                    final messages = snapshot.data.docs;
                    List<Widget> msgWidgets = [];
                    for (var msg in messages) {
                      final msgText = msg.data()['text'];
                      final msgSender = msg.data()['sender'];

                      final currentUser = loggedInUser.email;

                      final msgWidget = MessageBubble(
                        text: msgText,
                        sender: msgSender,
                        isMe: currentUser == msgSender,
                      );
                      msgWidgets.add(msgWidget);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        children: msgWidgets,
                      ),
                    );
                  }),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: msgTextController,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          msgText = value;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.indigo[300],
                      ),
                      onPressed: () {
                        msgTextController.clear();
                        _firestore.collection('messages').add({
                          'text': msgText,
                          'sender': loggedInUser.email,
                          'timestamp':
                              DateTime.now().toUtc().millisecondsSinceEpoch,
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});

  final String text;
  final String sender;
  final isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5.0,
            shadowColor: isMe ? Colors.white : Colors.indigo[300],
            color: isMe ? Colors.indigo[300] : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black87,
                    fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}