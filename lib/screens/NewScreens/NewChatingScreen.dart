import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../widgets/ShowToast.dart';
import '../../widgets/custom_appbar.dart';

class NewChatScreen extends StatefulWidget {
  final String userId;
  final String userFullName;
  final String userImage;
  final String myId;

  const NewChatScreen({Key? key,required this.myId, required this.userId, required this.userFullName, required this.userImage}) : super(key: key);

  @override
  State<NewChatScreen> createState() => _NewChatState();
}

class _NewChatState extends State<NewChatScreen> {
  TextEditingController messageController = TextEditingController();

  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;


  Future<void> uploadToFirestore() async {
    print("hiiiiii");

    Map<String, dynamic> dataMap = {
      "sendBy": widget.myId,
      "sendTo": widget.userId,
      "message": messageController.text.trim().toString(),
      "time": FieldValue.serverTimestamp(),
    };

    print("id is..........${widget.userId}");
    await firebaseFireStore
        .collection("chat_user")
        .doc(getChatId(widget.myId, widget.userId))
        .collection("chats")
        .add(dataMap);
    messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context: context, title: "Chat With Client", elevation: 0,),
      body:
      Column(
        children: [
          const SizedBox(height: 3,),
          ListTile(
            leading:ClipRRect(
              borderRadius:
              BorderRadius.circular(30.0),
              child:CachedNetworkImage(
                imageUrl:'${widget.userImage}',height: 60, width: 60, fit: BoxFit.cover,
                placeholder: (BuildContext context, String url) =>Image.asset('assets/images/profile.png',height: 60, width: 60, fit: BoxFit.cover,),
                errorWidget: (BuildContext context, String url, dynamic error) => Image.asset('assets/images/profile.png',height: 60, width: 60, fit: BoxFit.cover,),
              ),
            ),
            title: Text(widget.userFullName,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black87),),
            subtitle: const Text('User',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black87),),

          ),
          const Divider(color: Colors.black54,thickness: 1,endIndent: 10,indent: 10,),
          const SizedBox(height: 2,),
          // getChatResult.isEmpty?Center(child: CustomLoader(color: ColorConstant.buttonColor,)):
          Expanded(
            child: Container(
              height: height*0.80,
              child: ListView(
                reverse: true,
                children: [
                  Column(
                    children: [
                      StreamBuilder(
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.data != null) {
                            return listViewBuilderView(snapshot: snapshot);
                          } else {
                            return Column(
                              children: [],
                            );
                          }
                        },
                        stream: firebaseFireStore
                            .collection("chat_user")
                            .doc(getChatId(widget.myId, widget.userId))
                            .collection("chats")
                            .orderBy("time", descending: false)
                            .snapshots(),
                      ),
                      const SizedBox(height: 50,)
                    ],
                  ),
                ],
              ),
              // height: height * 0.78,
              // color: Colors.yellow,
              // child: ListView.builder(
              //   reverse: true,
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   itemCount: getChatResult.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     final bool isMe = userId == getChatResult[index].senderId;
              //     // final bool isSameUser = prevUserId == message.sender.id;
              //     // prevUserId = message.sender.id;
              //     return _chatBubble(getChatResult[index], isMe);
              //   },),
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

  Widget listViewBuilderView({required AsyncSnapshot<QuerySnapshot> snapshot}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 1),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
              onLongPress: () {
                deleteMessageDialogBox(snapshot.data!.docs[index].id);
              },
              child: messages(snapshot: snapshot, index: index));
        },
        itemCount: snapshot.data?.docs.length,
      ),
    );
  }

  Widget messages(
      {required AsyncSnapshot<QuerySnapshot> snapshot, required int index}) {
    return textMessageView(snapshot: snapshot, index: index);
  }

  Widget textMessageView(
      {required AsyncSnapshot<QuerySnapshot> snapshot,
        required int index}) =>
      Column(
        children: [
          Container(
            width: double.infinity,
            alignment: snapshot.data?.docs[index]["sendBy"] == widget.myId
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: snapshot.data?.docs[index]["sendBy"] == widget.myId
                      ? Colors.black38.withOpacity(0.1)
                      : Colors.yellow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    snapshot.data?.docs[index]["message"],
                    style: const TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data?.docs[index]["time"] == null
                        ? ""
                        : (DateFormat('HH:mm a').format(
                        snapshot.data?.docs[index]["time"].toDate()))
                        .toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    snapshot.data?.docs[index]["time"] == null
                        ? ""
                        : getTimeAgo(snapshot.data?.docs[index]["time"]),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  String getTimeAgo(Timestamp timestamp) {
    if (timestamp == null) {
      return "";
    }
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays > 1 && difference.inDays <= 5) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays > 5) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } else {
      // Handle future dates
      return 'Future date';
    }
  }

  deleteMessageDialogBox(String docId) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2),
        content: Text("Are you sure to delete this message"),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  "NO",
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //deleteMessage(docId);
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  "yes",
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 /* void deleteMessage(String docId) async {
    try {
      CollectionReference users =
      FirebaseFirestore.instance.collection('chatroom');
      await users.doc("admin_$userId").collection("chats").doc(docId).delete();

      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }  */
  _sendMessageArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(bottom: 5,top: 10),
          height: MediaQuery.of(context).size.height * 0.07,

          child: Row(
            children: <Widget>[

              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.indigo,width: 1)),
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type message',
                    ),
                    controller: messageController,
                    onChanged: (f) {
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (messageController.text.isEmpty) {
                    showToastMessage( "enter message");
                  } else {
                    uploadToFirestore();
                  }
                },
                child: Container(
                  height: 50, width: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.indigo),
                  child:const Text('Send',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),
                  textAlign: TextAlign.center,)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getChatId(String senderId, String userId) {
    if (int.parse(senderId) == int.parse(userId)) {
      return "$userId";
    } else if (int.parse(senderId) > int.parse(userId)) {
      print("${userId}_to_$senderId");
      return "${userId}_to_$senderId";
    } else {
      print("${senderId}_to_$userId");
      return "${senderId}_to_$userId";
    }
  }
}