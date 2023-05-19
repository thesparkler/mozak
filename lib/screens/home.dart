import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void goto(String path)
    {
      Navigator.of(context).pushNamed('$path');
    }

    List<String> options = ['Youth list','Add Weeklyforum','Add Center','Add Group','Take Attendance','Add Team'];

    return Padding(
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
    );
  }
}
