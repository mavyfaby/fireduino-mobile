import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncidentReportsView extends StatelessWidget {
  const IncidentReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, top: 5.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '5854 total number of incidents', style: TextStyle(
                fontSize: 12,
                height: 5
              ),
            ),
            Container(
              width: 350,
              height: 300,
              padding: const EdgeInsets.only(top: 20,right: 10,bottom: 10,left: 10),
              decoration: const BoxDecoration(
              color:  Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
              child:  Column(
                children: [
                   const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#5854', 
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        'Mar 18, 2023 at 8:25 AM', 
                        style: TextStyle(
                          fontSize: 12
                        ),
                      ),
                      
                    ],
                    
                  ),
                 const Expanded(
                    child: Center(
                    child: Text(
                      'Need Report'
                    ),
                    )
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {}, 
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF5C8CC),
                        ),
                        icon: const Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 20,
                            ), 
                            Text('Add Report', style: TextStyle(color: Colors.black,fontSize: 14, ), ),
                          ],
                        ),
                        label: const Text(''),
                        )
                    ],
                  )
                ],
                
              ),
              
              
            ),
            const Row(
              children: [
                Text('')
              ],
            ),

            Container(
              height: 300,
              width: 350,
              padding: const EdgeInsets.only(top: 20, left: 10,right: 10, bottom: 10),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
              ),
              child: const Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('#5853', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text('Feb 16, 2023 at 2:30 PM', style: TextStyle(fontSize: 12),)
                    ],

                  ),
                   Expanded(
                    child: Center(
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                      style: TextStyle(fontSize: 12),),
                    ),
                    ),

                  Column(
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fire Department:', style: TextStyle(fontSize: 12),),
                          Text('Fire Department 1', style: TextStyle(fontSize: 12),)
                        ],
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fireduino Responded: ', style: TextStyle(fontSize: 12)),
                          Text('Fireduino 2', style: TextStyle(fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text('Reported by Christine Lange', style: TextStyle(height: 5,fontSize: 12,fontWeight: FontWeight.bold))
                        ],
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