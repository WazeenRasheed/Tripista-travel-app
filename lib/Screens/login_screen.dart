import 'package:flutter/material.dart';
import 'package:tripista/Widgets/home_page_widgets/trip_title.dart';
import '../Components/custom_button.dart';
import '../Components/custom_textfield.dart';
import '../Components/styles.dart';
import '../Database/database_functions.dart';
import 'bottom_navigation.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

//login check
  Future<void> login() async {
    final usermail = mailController.text;
    final password = passwordController.text;

    // Validate the username and password against the database
    final user = await DatabaseHelper.instance.validateUser(usermail, password);

    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => bottomNavigationBar(userdata: user),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Login. Please check your email and password.'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional(-0.6, 1.08),
              children: [
                Container(
                  height: screenSize.height * 0.35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/welcome.png'))),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/tripista_logo.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  height: screenSize.height * 0.081,
                  width: screenSize.width * 0.18,
                )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.035,
            ),

            //Log in to your account
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back to Tripista',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Text(
                      '''Tripista designed to give you the power to plan your trips from ease.Tripista helps you create memorable journeys and keeps your travel budget on track.'''),
                  SizedBox(
                    height: screenSize.height * 0.045,
                  ),
                  Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),

                  //text fields
                  FieldName(text: 'Email'),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  myTextField(
                    controller: mailController,
                    hintText: 'Enter your email',
                    icon: Icons.email_rounded,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  FieldName(text: 'Password'),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  myTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    icon: Icons.key,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),

                  //login button
                  MyButton(
                      onTap: () {
                        login();
                      },
                      backgroundColor: primaryColor,
                      text: 'Log in',
                      textColor: backgroundColor),
                  SizedBox(
                    height: screenSize.height * 0.012,
                  ),

                  //Don’t have an account ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account ? ',
                        style: TextStyle(fontSize: 15, color: accentColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SignupScreen()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
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
