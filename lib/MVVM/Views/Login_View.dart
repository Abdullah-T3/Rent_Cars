// ignore_for_file: file_names

import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Colors.dart';
import '../../Responsive/UiComponanets/InfoWidget.dart';
import '../View%20Model/user_view_model.dart';

class LoginView extends StatefulWidget {
  final VoidCallback toggleLanguage;

  const LoginView({super.key, required this.toggleLanguage});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String isLoggedIn;
  bool isPressed = true;
  GlobalKey formKey = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginState();
    });
  }

  Future<void> _checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('token') ?? '';
    });

    if (isLoggedIn.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget buildHeader(context) {
    return Infowidget(builder: (context, deviceInfo) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: deviceInfo.screenWidth * 0.05,
            vertical: deviceInfo.screenHeight * 0.02),
        child: Column(
          children: [
            Text(
              S.of(context).login,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
            Text(
              S.of(context).Continue_to_login,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      );
    });
  }

  Widget buildTextField() {
    return Infowidget(builder: (context, deviceInfo) {
      return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_enter_your_username;
                }
                return null;
              },
              controller: usernameController,
              decoration: InputDecoration(
                labelText: S.of(context).username,
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: deviceInfo.screenHeight * 0.02),
            TextFormField(
              controller: passwordController,
              obscureText: isPressed,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_enter_your_password;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: S.of(context).password,
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                    },
                    icon: isPressed
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SizedBox(
              height: deviceInfo.screenHeight,
              width: deviceInfo.screenWidth,
              child: SingleChildScrollView(
                physics: deviceInfo.orientation == Orientation.landscape
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.05,
                    vertical: deviceInfo.screenHeight * 0.02,
                  ),
                  child: Column(
                    children: [
                      // Language toggle button
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceInfo.screenWidth * 0.45,),
                        child: SizedBox(
                          width: deviceInfo.screenWidth * 0.45,
                          height: deviceInfo.screenHeight * 0.05,
                          child: MaterialButton(
                            onPressed: widget.toggleLanguage,
                            child: Row(
                              children: [
                          
                                                        Padding(
                                padding:  EdgeInsets.only(top: deviceInfo.screenHeight * 0.02),
                                child: Text( S.of(context).change_language, style: const TextStyle(color: Colors.white),
                                )
                              ),
                              SizedBox(width: deviceInfo.screenWidth * 0.02,),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: deviceInfo.screenHeight * 0.02,
                                    ),
                                  child: const Icon( Icons.language, color: Colors.white,),
                              ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      buildHeader(context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: deviceInfo.screenHeight * 0.07),
                        child: buildTextField(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: deviceInfo.localWidth * 0.15),
                        child: Image.asset("assets/images/desk.png"),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: deviceInfo.screenHeight * 0.1),
                        child: Container(
                          height: deviceInfo.localHeight * 0.08,
                          width: deviceInfo.localWidth * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MyColors.primaryColor),
                          child: MaterialButton(
                            onPressed: () async {
                              await userViewModel.login(
                                usernameController.text,
                                passwordController.text,
                              );
                              if (userViewModel.token.isNotEmpty) {
                                Navigator.pushReplacementNamed(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    '/home');
                              }
                              if (userViewModel.token.isEmpty) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(S
                                        // ignore: use_build_context_synchronously
                                        .of(context)
                                        .Invalid_username_or_password),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              S.of(context).login,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
