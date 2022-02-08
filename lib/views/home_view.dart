
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:history/models/question.dart';
import 'package:history/services/auth_service.dart';
import 'package:history/views/histroy_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _answer = '';
  bool _askBtnActive = false;
  TextEditingController _questionController = TextEditingController();
  Question _question = Question();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Decider"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.shopping_bag),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryView()));
              },
              child: Icon(Icons.history),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Decisions Left: ##"),
              ),
              Spacer(),
              _buildQuestionForm(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionForm() {
    return Column(
      children: [
        Text("Should I", style: Theme.of(context).textTheme.headline4),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
          child: TextField(
            decoration: InputDecoration(
              helperText: 'Enter A Question',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: _questionController,
            onChanged: (value){
              setState(() {
                _askBtnActive = value.length >= 3 ? true : false;
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: _askBtnActive == true ? _answerQuestion : null,
          child: Text("Ask"),
        ),
        _questionAndAnswer(),
      ],
    );
  }

  String _getAnswer() {
    var answerOptions = ['yes', 'no','definitely'];
    return answerOptions[Random().nextInt(answerOptions.length)];
  }

  Widget _questionAndAnswer(){
    return Column(
      children: [
        Text('Should I ${_question.query} ?'),
        Text(_answer),
      ],
    );
  }

  void _answerQuestion () async{
    setState(() {
      _answer = _getAnswer();
    });
    _question.query = _questionController.text;
    _question.answer = _answer;
    _question.created = DateTime.now();

    await FirebaseFirestore.instance.collection('users').doc(AuthService().currentUser?.uid).collection('question').add(_question.toJson());
    _questionController.text = '';
}
}
