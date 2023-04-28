import 'package:flutter/material.dart';

class AddFireduinoPage extends StatelessWidget {
  const AddFireduinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController serialId = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Fireduino"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Note: Make sure the fireduino device is connected to the server."),
            const SizedBox(height: 16),
            TextField(
              controller: serialId,
              decoration: const InputDecoration(
                label: Text("Fireduino Serial ID"),
                filled: true,
                prefixIcon: Icon(Icons.fireplace_outlined)
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    
                  },
                  child: const Text("Check device")
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: () {

                  },
                  child: const Text("Add device")
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}