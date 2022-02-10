import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children:  const [
          SizedBox(
            height: 100,
            child: Center(
              child: Text("Welcome",
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

}
