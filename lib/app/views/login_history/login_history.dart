import 'package:flutter/material.dart';

class LoginHistoryView extends StatelessWidget {
  const LoginHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent login by Maverick Fabroa (10 mins ago)',
              style: TextStyle(
                fontSize: 12,
                height: 5
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: new NetworkImage('https://images.hindustantimes.com/tech/rf/image_size_960x540/HT/p2/2018/09/08/Pictures/_7ae928c8-b34e-11e8-bb15-a1f88311a832.jpg'),
                  ),
                  Column(
                    children: [
                       Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'Maverick Fabroa',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
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
                      
                    ],
                  )
                ],
              ),

            ),
            
            Container(
              child: const Text(''),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: new NetworkImage('https://images.hindustantimes.com/tech/rf/image_size_960x540/HT/p2/2018/09/08/Pictures/_7ae928c8-b34e-11e8-bb15-a1f88311a832.jpg'),
                  ),
                  Column(
                    children: [
                       Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'Christine Lange',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
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
                      
                    ],
                  )
                ],
              ),

            ),

            Container(
              child: const Text(''),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: new NetworkImage('https://images.hindustantimes.com/tech/rf/image_size_960x540/HT/p2/2018/09/08/Pictures/_7ae928c8-b34e-11e8-bb15-a1f88311a832.jpg'),
                  ),
                  Column(
                    children: [
                       Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'Christine Lange',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
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
                      
                    ],
                  )
                ],
              ),

            ),

            Container(
              child: const Text(''),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: new NetworkImage('https://images.hindustantimes.com/tech/rf/image_size_960x540/HT/p2/2018/09/08/Pictures/_7ae928c8-b34e-11e8-bb15-a1f88311a832.jpg'),
                  ),
                  Column(
                    children: [
                       Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'Jewel Cedrick Gesim',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
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