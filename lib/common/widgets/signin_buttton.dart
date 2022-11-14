import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final Function()? onPressed;
  const SignInButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        'assets/google.png',
        height: 30,
      ),
      label: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          'Sign in With Google',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
