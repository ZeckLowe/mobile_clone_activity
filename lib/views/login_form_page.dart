import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/models/models.dart';
import 'package:mobile_clone_activity/navigations/tabbar.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:mobile_clone_activity/views/start_screen.dart';

class Login extends ConsumerWidget {
  Login({super.key});
  late final TextEditingController emailCtrl = TextEditingController();
  late final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  backButton(),
                  SizedBox(
                    width: 130,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Email',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              text_field1(controller: emailCtrl),
              SizedBox(
                height: 15,
              ),
              Text(
                'Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              text_field2(controller: passCtrl),
              SizedBox(
                height: 50,
              ),
              LoginButton(emailController: emailCtrl, passController: passCtrl)
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton(
      {super.key, required this.emailController, required this.passController});
  final TextEditingController emailController;
  final TextEditingController passController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final AsyncValue<List<User>> usersAsyncValue = ref.watch(userProvider);
        final String inputEmail = emailController.text.trim();
        final String inputPass = passController.text.trim();
        bool emailIsValid = false;
        bool passIsValid = false;
        usersAsyncValue.when(
          data: (users) {
            for (var user in users) {
              if (user.email == inputEmail) {
                emailIsValid = true;
                ref.read(currentUserProvider.notifier).state = user.name;
                ref.read(userIdProvider.notifier).state = user.id!;
                if (user.password == inputPass) {
                  passIsValid = true;
                }
              }
            }
          },
          loading: () => CircularProgressIndicator(),
          error: (err, stackTrace) => Center(child: Text("Error: $err")),
        );
        if (emailIsValid == false) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Email Does not Exist'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please enter valid email"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        } else if (passIsValid == false) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Incorrect Password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please enter valid password"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Tabbar(),
            ),
          );
        }
      },
      child: Center(
        child: Container(
          width: 115,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Text(
              'Login',
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

class text_field1 extends StatelessWidget {
  const text_field1({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 134, 134, 134),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: screenWidth,
      height: 45,
      child: Row(
        children: [
          Container(
            width: screenWidth - 90,
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
        ],
      ),
    );
  }
}

class text_field2 extends ConsumerWidget {
  const text_field2({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final bool hidePass = ref.watch(showPassIconProvider);
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 134, 134, 134),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: screenWidth,
      height: 45,
      child: Row(
        children: [
          Container(
            width: screenWidth - 90,
            height: 45,
            child: TextField(
              obscureText: hidePass,
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
            child: IconButton(
              icon: Icon(hidePass ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                ref.read(showPassIconProvider.notifier).state = !hidePass;
              },
            ),
          ),
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
            builder: (context) => StartPage(),
          ),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 39, 39, 39),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Image.asset(
          'assets/Chevron left.png',
        ),
      ),
    );
  }
}
