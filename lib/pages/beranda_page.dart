import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text("HHAHA"),
                      ),
                      Text("Halo Adam Rasyid",
                          style: TextStyle(fontFamily: 'Inter', fontSize: 16)),
                    ],
                  ),
                  Text("Halo Adam Rasyid"),
                  Text("Ini Search "),
                  Text("Eksplor Tempat Camping"),
                ],
              ),
            ),
            // Text("Filter") Biar bisa di scroll horizontal
            Column(children: [Text("1"), Text("1"), Text("1")])
          ],
        ),
      ),
    );
  }
}
