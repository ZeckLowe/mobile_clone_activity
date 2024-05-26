import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:mobile_clone_activity/views/sign_up_page.dart';
import 'package:mobile_clone_activity/views/sign_up_page3.dart';

class SignUp2 extends StatelessWidget {
  SignUp2({super.key});
  late final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  backButton(),
                  SizedBox(
                    width: 90,
                  ),
                  Text(
                    'Create Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Create Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              text_field(
                width: screenWidth,
                controller: passController,
              ),
              Text(
                'Use atleast 8 characters.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 50,
              ),
              NextButton(passController: passController),
            ],
          ),
        ),
      ),
    );
  }
}

class NextButton extends ConsumerWidget {
  const NextButton({super.key, required this.passController});
  final TextEditingController passController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(password.notifier).state = passController.text.trim();
        print(ref.read(password));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp3(),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 100, 99, 99),
              borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class text_field extends StatelessWidget {
  const text_field({super.key, required this.width, required this.controller});
  final double width;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 134, 134, 134),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      width: width,
      height: 45,
      child: TextField(
        obscureText: true,
        controller: controller,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class backButton extends StatelessWidget {
  const backButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp(),
          ),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Image.asset(
          'assets/Chevron left.png',
        ),
      ),
    );
  }
}
