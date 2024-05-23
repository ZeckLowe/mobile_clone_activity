import 'package:flutter/material.dart';
import 'package:mobile_clone_activity/views/sign_up_page2.dart';
import 'package:mobile_clone_activity/views/sign_up_page4.dart';

class SignUp3 extends StatelessWidget {
  const SignUp3({super.key});

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
                    'Create Account',
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
                'What\'s your gender?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              text_field(width: screenWidth),
              SizedBox(
                height: 50,
              ),
              NextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contex) => SignUp4(),
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
  const text_field({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 134, 134, 134),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      width: width,
      height: 45,
      child: Row(
        children: [
          Container(
            width: width - 100,
            height: 45,
            child: TextField(
              // controller: controller,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // hintText: 'Email',
                // hintStyle: TextStyle(
                //   color: Color(0xFF9EB3C2),
                //   fontSize: 15,
                // ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            child: Image.asset('assets/checkSymbol.png'),
          )
        ],
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
            builder: (contex) => SignUp2(),
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
