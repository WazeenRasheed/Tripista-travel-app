import 'package:flutter/material.dart';
import '../Components/custom_button.dart';
import '../Components/custom_textfield.dart';
import '../Components/styles.dart';
import '../Database/database_functions.dart';
import '../Database/models/user_model.dart';
import '../Widgets/home_page_widgets/trip_title.dart';
import 'bottom_navigation.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                        color: accentColor,
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
                height: screenSize.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Tripista',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    Text(
                        '''Tripista is your ultimate travel companion that lets you plan your trips with ease.'''),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.005,
                    ),

                    //name textField
                    FieldName(text: 'Name'),
                    SizedBox(
                      height: screenSize.height * 0.005,
                    ),
                    myTextField(
                      controller: nameController,
                      hintText: 'Enter your username',
                      icon: Icons.person,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username required';
                        } else if (nameController.text.trim().isEmpty) {
                          return 'Username required ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * 0.005,
                    ),

                    //mail textField
                    FieldName(text: 'Email Address'),
                    SizedBox(
                      height: screenSize.height * 0.005,
                    ),
                    myTextField(
                      controller: mailController,
                      hintText: 'Enter your email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!isEmailValid(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * 0.005,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldName(text: 'Password'),
                            SizedBox(
                              height: screenSize.height * 0.005,
                            ),
                            myTextField(
                              controller: passwordController,
                              hintText: 'Enter your password',
                              icon: Icons.key,
                              obscureText: true,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                        SizedBox(
                          width: screenSize.width * 0.04,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldName(text: 'Confirm Password'),
                            SizedBox(
                              height: screenSize.height * 0.005,
                            ),
                            myTextField(
                              controller: confirmPwdController,
                              hintText: 'Confirm password',
                              obscureText: true,
                              icon: Icons.lock,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Password is required';
                                } else if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.019,
                    ),

                    //signup button
                    MyButton(
                        onTap: () {
                          onSignupButtonClicked();
                        },
                        backgroundColor: primaryColor,
                        text: 'Sign up',
                        textColor: backgroundColor),
                    SizedBox(
                      height: screenSize.height * 0.012,
                    ),

                    //Already have an account ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(fontSize: 15, color: accentColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => LoginScreen()));
                          },
                          child: Text(
                            'Log in',
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSignupButtonClicked() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text.trim();
      final mail = mailController.text.trim();
      final password = passwordController.text.trim();

      // Check if the email is already in the database
      final mailExists = await DatabaseHelper.instance.checkIfMailExists(mail);

      if (mailExists) {
        // Show an error message if the email already exists in the database.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'This mail is already registered. Please use a different mail.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final user = UserModal(name: name, mail: mail, password: password);

      final userid = await DatabaseHelper.instance.addUser(user);
      user.id = userid;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => bottomNavigationBar(userdata: user),
        ),
        (route) => false,
      );
    }
  }

  //Email validation
  bool isEmailValid(String email) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
