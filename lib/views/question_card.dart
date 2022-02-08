import 'package:flutter/material.dart';
import 'package:history/models/question.dart';
import 'package:history/views/view_page.dart';
import 'package:intl/intl.dart';

class QuestionCard extends StatelessWidget {
  final Question _question;
  QuestionCard(this._question);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewPage()));
      },
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text('Should I ${_question.query}'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(_question.answer!, style: Theme.of(context).textTheme.headline6,),
                    Spacer(),
                    Text('${DateFormat('MM/dd/yyyy').format(_question.created!).toString()}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
