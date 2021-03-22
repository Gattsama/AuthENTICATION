import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscurePassword = true;
  bool _rememberPassword = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(
              'SIGN IN',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 26.0),
            ),
            TextField(
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Enter User Name',
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  )),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              ),
            ),
            TextField(
              obscureText: obscurePassword,
              style: TextStyle(color: Colors.white, fontSize: 22),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(FontAwesomeIcons.eye),
                    onPressed: () {
                      print(obscurePassword);
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    }),
                labelText: 'Enter Password',
                labelStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                    activeColor: Colors.orange,
                    value: _rememberPassword,
                    onChanged: (newValue) {
                      setState(() {
                        _rememberPassword = newValue;
                      });
                    }),
                Text(
                  'Remember Password',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white),
              child: Text(
                'LOG IN',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                ),
                SizedBox(width: 30),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.red,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                ),
                SizedBox(width: 30),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.red,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Forgot Password',
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: Colors.red[800]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account. Create One:  ',
                    style: TextStyle(color: Colors.orange),
                  ),
                  Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
