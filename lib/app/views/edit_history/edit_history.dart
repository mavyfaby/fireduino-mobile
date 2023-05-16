import 'package:flutter/material.dart';

class EditHistoryView extends StatelessWidget {
  const EditHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '150 total number of edit logs',
              style: TextStyle(
                fontSize: 12,
                height: 5
              ),
            ),

            Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
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
                                ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 10,left: 30,bottom: 10, right: 20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fireduino 1',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12
                                ),
                              ),
                              Text(
                                'Last edit 10 mins ago',
                                  style: TextStyle(
                                    fontSize: 10
                                  ),
                                )
                            ],
                          ),
                  ),
                      Container(
                        padding: const EdgeInsets.only(left: 50),
                        child: const Text(
                          'Christine Lange',
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                      Container(
                        padding: EdgeInsets.only(top: 2,right: 10,left: 15,bottom: 2),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Type',
                            style: TextStyle(
                              fontSize: 12
                            ),),
                            Text('Fireduino 1 IP Address',
                            style: TextStyle(
                              fontSize: 12
                            ),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2,right: 10,left: 15,bottom: 2),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Before',
                            style: TextStyle(
                              fontSize: 12
                            ),),
                            Text('192.168.1.104',
                            style: TextStyle(
                              fontSize: 12
                            ),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2,right: 10,left: 15,bottom: 2),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('After',
                            style: TextStyle(
                              fontSize: 12
                            ),),
                            Text('192.168.1.101',
                            style: TextStyle(
                              fontSize: 12
                            ),)
                          ],
                        ),
                      ),
                ],
              ),
            ),
            Container(
              child: const Text(
                ''
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
                        padding: const EdgeInsets.only(top: 10,left: 30,bottom: 10, right: 20),
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
                              'Last edit 54 mins ago',
                              style: TextStyle(
                                fontSize: 10
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left:50),
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
              child: const Text(
                ''
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
                        padding: const EdgeInsets.only(top: 10,left: 30,bottom: 10, right: 20),
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
                              'Last edit 2 hours ago',
                              style: TextStyle(
                                fontSize: 10
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left:50),
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
          ],
        ),
      ),
    );
  }
}