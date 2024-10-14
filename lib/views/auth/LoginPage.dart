import 'package:code/views/auth/components/HorizontalLine.dart';
import 'package:code/views/auth/components/JarvisLogoAndLabel.dart';
import 'package:code/views/auth/components/PrivacyPolicy.dart';
import 'package:code/views/auth/components/RichTextLogin.dart';
import 'package:code/views/auth/components/RichTextRegister.dart';
import 'package:flutter/material.dart';
import 'package:code/views/auth/buttons/LoginButton.dart';
import 'package:code/views/auth/buttons/RegisterButton.dart';
import 'package:code/views/auth/buttons/ResetPasswordButton.dart';
import 'package:code/views/auth/buttons/SignInWithGoogleButton.dart';
import 'package:code/views/auth/buttons/SwitchLoginButton.dart';
import 'package:code/views/auth/buttons/ForgotPasswordButton.dart';
import 'package:code/views/auth/fields/Field.dart';
import 'package:code/views/auth/fields/PasswordField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.state});
  final String state;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String currentState;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    currentState = widget.state;
  }

  void _updateState(String newState) {
    FocusScope.of(context).unfocus();
    setState(() {
      currentState = newState;
    });
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () { Navigator.of(context).pop(); },
              icon: const Icon(Icons.close, size: 25, color: Colors.grey,)
          ),
        ),
        body: Row(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const JarvisLogoAndLabel(),
                    const SizedBox(height: 15),
                    const SignInWithGoogleButton(),
                    const HorizontalLine(),
                    if (currentState == "Forgot password") ...[
                      Field(
                          fieldName: 'Email',
                          controller: emailController,
                          focusNode: emailFocusNode,
                          focusNodeNext: passwordFocusNode
                      ),
                      const SizedBox(height: 15),
                      const ResetPasswordButton(),
                      const SizedBox(height: 15),
                      RichTextLogin(updateState: _updateState),
                    ] else ...[
                      SwitchLoginButton(isLoginMode: currentState == 'Login' ? true : false, onMessageChange: _updateState),
                      const SizedBox(height: 15),
                      Field(
                          fieldName: 'Username',
                          controller: usernameController,
                          focusNode: usernameFocusNode,
                          focusNodeNext: currentState == "Register" ? emailFocusNode : passwordFocusNode
                      ),
                      const SizedBox(height: 15),
                      if (currentState == "Register") ...[
                        Field(
                            fieldName: 'Email',
                            controller: emailController,
                            focusNode: emailFocusNode,
                            focusNodeNext: passwordFocusNode
                        ),
                        const SizedBox(height: 15),
                      ],
                      PasswordField(controller: passwordController, focusNode: passwordFocusNode),
                      const SizedBox(height: 15),
                      if (currentState == "Login") ...[
                        ForgotPasswordButton(onMessageChange: _updateState,),
                        const SizedBox(height: 15),
                        const LoginButton(),
                        const SizedBox(height: 15),
                        RichTextRegister(updateState: _updateState)
                      ] else if (currentState == "Register") ...[
                        const RegisterButton(),
                        const SizedBox(height: 15),
                        const PrivacyPolicy(),
                      ]
                    ]
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}