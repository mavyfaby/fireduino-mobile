import 'package:flutter/material.dart';

class AccessLogsView extends StatelessWidget {
  const AccessLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '150 total number of access Fireduino Logs',
              style: TextStyle(
                fontSize: 12,
                height: 5
              ),
            ),
            Container(
              width: 350,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
                        child: const Column(
                          children: [
                            Text(
                              'MAR',
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                            Text(
                              '18',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10,left: 10,bottom: 10, right: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fireduino 1',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                
                              ),
                            ),
                            Text(
                              'Last accessed 10 mins ago',
                              style: TextStyle(
                                fontSize: 10
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Maverick Fabroa',
                              style: TextStyle(
                                fontSize: 12
                              ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            Container(
              child: const Text(''),
            ),

            Container(
              width: 350,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
                        child: const Column(
                          children: [
                            Text(
                              'MAR',
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                            Text(
                              '18',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10,left: 10,bottom: 10, right: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fireduino 2',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                
                              ),
                            ),
                            Text(
                              'Last accessed 54 mins ago',
                              style: TextStyle(
                                fontSize: 10
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Christine Lange',
                              style: TextStyle(
                                fontSize: 12
                              ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            Container(
              child: const Text(''),
            ),

            Container(
              width: 350,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
                        child: const Column(
                          children: [
                            Text(
                              'MAR',
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                            Text(
                              '18',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10,left: 10,bottom: 10, right: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fireduino 3',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                
                              ),
                            ),
                            Text(
                              'Last accessed 2 hours ago',
                              style: TextStyle(
                                fontSize: 10
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Maverick Fabroa',
                              style: TextStyle(
                                fontSize: 12
                              ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            Container(
              child: const Text(''),
            ),

            Container(
              width: 350,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
                        child: const Column(
                          children: [
                            Text(
                              'MAR',
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                            Text(
                              '18',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10,left: 10,bottom: 10, right: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fireduino 4',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                
                              ),
                            ),
                            Text(
                              'Last accessed 5 hours ago',
                              style: TextStyle(
                                fontSize: 10
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Jewel Cedrick Gesim',
                              style: TextStyle(
                                fontSize: 12
                              ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}