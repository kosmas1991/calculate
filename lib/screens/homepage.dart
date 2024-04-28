import 'package:calculate/screens/VIXscreen.dart';
import 'package:calculate/screens/upgradedowngradescreen.dart';
import 'package:calculate/widgets/icontextbutton.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 236, 236, 236),
            const Color.fromARGB(255, 190, 190, 190)
          ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconTextButton(
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VIXscreen(),
                        ));
                  },
                  text: 'Ποσό επιστροφής βάσει ημερών χρήσης',
                  icon: Icons.euro,
                ),
                SizedBox(
                  height: 15,
                ),
                IconTextButton(
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpgradeDowngradeScreen(),
                        ));
                  },
                  text: 'Ποσό σε αναβάθμιση/υποβάθμιση',
                  icon: Icons.align_horizontal_right_rounded,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Built by Kosmas KoG Gourgiotis',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
