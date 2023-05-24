import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text('Mozak'),
      centerTitle: true,
    );

    final bodyHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    void goto(String path)
    {
      Navigator.of(context).pushNamed('$path');
    }

    List<String> options = ['Youths','Weekly Forum Events','Centers','Groups','Attendance','Teams'];

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: bodyHeight,
        width: bodyWidth,
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: options.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
            ),
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.amber[100],
                  elevation: 5,
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: ()=>goto(options[index]),
                      child:Text('${options[index]}',style: TextStyle(color: Colors.blue[900])),
                    ),
                  )
              );
            }),
      ),
    );
  }
}
