import 'package:flutter/material.dart';

import '../homepage_controllers/homepage_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomepageController _controller = HomepageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BEM Installers'),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'To register a newly installed smart energy meter, click on the button below:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                // color: Colors.purple[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                onTap: (() {
                  _controller.goToScanQRcode(context);
                }),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey[200],
                  ),
                  child: const Center(
                    child: Text(
                      'Register a new meter',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
