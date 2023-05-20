import 'package:flutter/material.dart';

class YouthList extends StatefulWidget {
  const YouthList({Key? key}) : super(key: key);

  @override
  State<YouthList> createState() => _YouthListState();
}

class _YouthListState extends State<YouthList> {
  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text('Youth Data'),
      centerTitle: true,
    );

    final bodyHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: bodyHeight,
        width: bodyWidth,
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_reaction_outlined),
        onPressed: (){}
      ),
    );
  }
}