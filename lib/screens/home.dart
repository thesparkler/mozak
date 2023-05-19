import 'package:flutter/material.dart';
import 'package:mozak/screens/weekly_forum_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(

        builder: (BuildContext context , BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                height: constraints.maxHeight * 0.33,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Youths'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all()
                ),
                height: constraints.maxHeight * 0.33,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WeeklyForumEvents()));
                          },
                          child: Text('Weekly Forum Events'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Weekly Forum Attendance'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all()
                ),
                height: constraints.maxHeight * 0.33,
                child: Row(
                  children: [
                    Expanded(

                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: TextButton(

                          onPressed: () {},
                          child: Text('Centers'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Groups'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );

        }
      ),
    );
  }
}
