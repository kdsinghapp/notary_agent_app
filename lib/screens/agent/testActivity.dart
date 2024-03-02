import 'package:flutter/material.dart';

class TestActivity extends StatefulWidget {
  @override
  State<TestActivity> createState() {
    return _TestState();
  }
}

enum TestName { Arvind, Ravindra }

class _TestState extends State<TestActivity> {
  final nameNotifier = ValueNotifier(TestName.Arvind);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestActivity'),
      ),
      body: Container(
          child: ValueListenableBuilder<TestName>(
              valueListenable: nameNotifier,
              builder: (context, TestName testName, child) {
                switch (testName) {
                  case TestName.Arvind:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Arvind"),
                        GestureDetector(
                          onTap: () {
                            nameNotifier.value = TestName.Ravindra;
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("Change Name")),
                        )
                      ],
                    );
                  case TestName.Ravindra:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Ravindra"),
                        GestureDetector(
                          onTap: () {
                            nameNotifier.value = TestName.Arvind;
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("Change Name")),
                        )
                      ],
                    );
                }
              })),
    );
  }
}
