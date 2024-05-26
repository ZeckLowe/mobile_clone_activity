import 'package:flutter/material.dart';
import 'package:mobile_clone_activity/models/models.dart';
import 'package:mobile_clone_activity/navigations/tabbar.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:mobile_clone_activity/views/sign_up_page3.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/views/start_screen.dart';

class SignUp4 extends ConsumerWidget {
  SignUp4({super.key});
  late final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isChecked1 = ref.watch(isChecked1Provider);
    final isChecked2 = ref.watch(isChecked2Provider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
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
                'What\'s your name?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              text_field(width: screenWidth, controller: nameController),
              Text(
                'This appears on your spotify profile.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: screenWidth - 50,
                height: 2,
                decoration: BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 25,
              ),
              PrivacyPolicy(screenWidth: screenWidth),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Please send me news and offers from Spotify.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Checkbox(
                    value: isChecked1,
                    onChanged: (bool? value) {
                      ref.read(isChecked1Provider.notifier).state = value!;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Share my registration data with Spotify\'s content providers for',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Checkbox(
                    value: isChecked2,
                    onChanged: (bool? value) {
                      ref.read(isChecked2Provider.notifier).state = value!;
                    },
                  ),
                ],
              ),
              Text(
                'marketing purposes',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              NextButton(nameController: nameController),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'By tapping on “Create account”, you agree to the spotify Terms of Use.',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Terms of Use',
            style: TextStyle(
                color: Color.fromARGB(255, 69, 203, 74),
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'To learn more about how Spotify collect, uses, shares and protects your personal data, Please see the Spotify Privacy Policy.',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Privacy Policy',
            style: TextStyle(
                color: Color.fromARGB(255, 69, 203, 74),
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class NextButton extends ConsumerWidget {
  const NextButton({super.key, required this.nameController});
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        ref.read(name.notifier).state = nameController.text.trim();
        final String userName = ref.read(name);
        final String userGender = ref.read(gender);
        final String email = ref.read(userEmail);
        final String userPassword = ref.read(password);
        print(userName);
        print(userGender);
        print(email);
        print(userPassword);
        await ref.read(userCreateProvider.notifier).addUser(User(
            name: userName,
            gender: userGender,
            email: email,
            password: userPassword));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartPage(),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Text(
              'Create an account',
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
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: width - 50,
      height: 45,
      child: Row(
        children: [
          Container(
            width: width - 105,
            height: 45,
            child: TextField(
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
            builder: (context) => SignUp3(),
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
