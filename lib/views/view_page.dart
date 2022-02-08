import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:history/models/question.dart';
import 'package:history/services/auth_service.dart';
import 'package:history/views/question_card.dart';
import 'package:intl/intl.dart';

class ViewPage extends StatefulWidget {

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List<Object> view = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: view.length,
          itemBuilder: (context, index){

            return QuestionCard(view[index] as Question);
          },
        ),
      ),
    );
  }
  Future getView() async{
    final uid = AuthService().currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('question')
        .orderBy('created',descending: true)
        .get();

    setState(() {
      view = List.from(data.docs.map((doc) => Question.fromSnapshot(doc)));
    });
  }
}


