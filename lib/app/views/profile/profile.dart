import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Profile'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle, 
                      size: 160.0,
                      ), 
                      onPressed: (){

                      },
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
                        child: const Text(
                          'Christine Lange', 
                          style: TextStyle(
                      
                            
                            height: 3,
                            fontSize: 25
                            
                            ),
                            ),
                      ),
                          
                 Column(
                   children: [
                     ListTile(
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Dark Mode'),
                      trailing: Switch(value: false, onChanged: (v){}),
                     ),
                     const ListTile(
                      leading: Icon(Icons.person_2_outlined),
                      title: Text('Username'),
                      subtitle: Text('dinotine'),
                      trailing: Icon(Icons.arrow_right),
                     ),
                     const ListTile(
                      leading: Icon(Icons.lock_outline_rounded),
                      title: Text('Password'),
                      subtitle: Text('Change Password'),
                      trailing: Icon(Icons.arrow_right),
                     )
                   ],
                 )

                ],
              ),
              
            ),
        ],
      ),
    );
  }
}