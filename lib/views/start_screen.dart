import 'package:flutter/material.dart';
import 'package:mobile_clone_activity/views/home.dart';
import 'package:mobile_clone_activity/widgets/signup_buttons.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Stack(
        children: [
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.55,
              child: Image.asset(
                'assets/start_screen.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.45,
              child: Column(
                children: [
                  Text(
                    'Millions of Songs.',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Free on Spotify.',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 13),
                  SignUpButtons(),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    },
                    child: Text(
                      'Log in',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
