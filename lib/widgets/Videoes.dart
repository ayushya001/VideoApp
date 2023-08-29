import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videorells extends StatelessWidget {
  const Videorells({Key? key}) : super(key: key);

  Future<List<DocumentSnapshot>> getAllDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Videos').get();
    return querySnapshot.docs;
  }


  @override
  Widget build(BuildContext context) {


    final mq = MediaQuery.of(context).size;
    return Scaffold();


    // title: Text(documents[index]['title']),
    // subtitle: Text(documents[index]['description
  }
}
