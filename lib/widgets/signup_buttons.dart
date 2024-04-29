import 'package:flutter/material.dart';

class SignUpButtons extends StatefulWidget {
  const SignUpButtons({super.key});

  @override
  State<SignUpButtons> createState() => _SignUpButtonsState();
}

class _SignUpButtonsState extends State<SignUpButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            RoundedButton(
              text: 'Sign up free',
              onPressed: () {},
              isGreen: true,
            ),
            SizedBox(height: 10),
            RoundedButton(
              text: 'Continue with Google',
              onPressed: () {},
              icon: AssetImage('assets/googl_logo.png'),
            ),
            SizedBox(height: 10),
            RoundedButton(
                text: 'Continue with Facebook',
                onPressed: () {},
                icon: AssetImage('assets/facebook_logo.png')),
            SizedBox(height: 10),
            RoundedButton(
                text: 'Continue with Apple',
                onPressed: () {},
                icon: AssetImage('assets/apple_logo.png')),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final AssetImage? icon;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final bool isGreen;

  const RoundedButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.height = 49,
    this.width = 337,
    this.isGreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(
              color: isGreen ? Color(0xff1ED760) : Colors.white,
              width: 0.6,
            ),
          ),
          primary: isGreen ? Color(0xff1ED760) : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment:
              icon != null ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if (icon != null)
              Image(
                image: icon!,
                width: 24, // Adjust icon size as needed
                height: 24,
              ),
            if (icon != null && text.isNotEmpty) SizedBox(width: 48),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isGreen ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
