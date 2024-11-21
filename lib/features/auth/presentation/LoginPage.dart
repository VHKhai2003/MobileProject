import 'package:code/features/auth/presentation/components/HorizontalLine.dart';
import 'package:code/features/auth/presentation/components/JarvisLogoAndLabel.dart';
import 'package:code/features/auth/presentation/components/PrivacyPolicy.dart';
import 'package:code/features/auth/presentation/components/RichTextLogin.dart';
import 'package:code/features/auth/presentation/components/RichTextRegister.dart';
import 'package:code/features/auth/providers/AuthProvider.dart';
import 'package:code/features/chat/presentation/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:code/features/auth/presentation/buttons/LoginButton.dart';
import 'package:code/features/auth/presentation/buttons/RegisterButton.dart';
import 'package:code/features/auth/presentation/buttons/ResetPasswordButton.dart';
import 'package:code/features/auth/presentation/buttons/SignInWithGoogleButton.dart';
import 'package:code/features/auth/presentation/buttons/SwitchLoginButton.dart';
import 'package:code/features/auth/presentation/buttons/ForgotPasswordButton.dart';
import 'package:code/features/auth/presentation/fields/Field.dart';
import 'package:code/features/auth/presentation/fields/PasswordField.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  String? errorMessage;
  bool isLoading = false;

  void _login() async {
    setState(() {
      errorMessage = null;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final email = usernameController.text.trim();
    final password = passwordController.text;

    final emailRegex = RegExp(r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.][a-zA-Z]{2,3})+$');

    if (email.isEmpty) {
      setState(() {
        errorMessage = "Email cannot be empty.";
      });
      return;
    }
    if (password.isEmpty) {
      setState(() {
        errorMessage = "Password cannot be empty.";
      });
      return;
    }
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        errorMessage = "Email is not in correct format.";
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    String? result = await authProvider.login(email, password);
    if (result != "success") {
      setState(() {
        isLoading = false;
        errorMessage = result;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = null;
      });
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ChatPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
              const end = Offset.zero; // Kết thúc tại vị trí gốc
              const curve = Curves.easeInOut; // Hiệu ứng chuyển cảnh
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            }),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    currentState = widget.state;
    usernameFocusNode.addListener(() {
      if (usernameFocusNode.hasFocus) {
        _scrollToFocusedField(usernameFocusNode);
      }
    });
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        _scrollToFocusedField(passwordFocusNode);
      }
    });
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        _scrollToFocusedField(emailFocusNode);
      }
    });
    confirmPasswordFocusNode.addListener(() {
      if (confirmPasswordFocusNode.hasFocus) {
        _scrollToFocusedField(confirmPasswordFocusNode);
      }
    });
  }

  void _scrollToFocusedField(FocusNode focusNode) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = focusNode.context;
      if (context != null) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        Future.delayed(const Duration(milliseconds: 350), () {
          var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          final fieldBottomPosition = offset.dy + renderBox.size.height;
          final screenHeight = MediaQuery.of(context).size.height;
          if (fieldBottomPosition > screenHeight - keyboardHeight - 10) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  void _updateState(String newState) {
    FocusScope.of(context).unfocus();
    setState(() {
      currentState = newState;
    });
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     icon: const Icon(
          //       Icons.arrow_back,
          //       size: 25,
          //       color: Colors.grey,
          //     )),
        ),
        body: ListView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 30),
            children: [
              Row(
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
                              focusNodeNext: passwordFocusNode),
                          const SizedBox(height: 15),
                          const ResetPasswordButton(),
                          const SizedBox(height: 15),
                          RichTextLogin(updateState: _updateState),
                        ] else ...[
                          SwitchLoginButton(
                              isLoginMode:
                                  currentState == 'Login' ? true : false,
                              onMessageChange: _updateState),
                          const SizedBox(height: 15),
                          Field(
                              fieldName: 'Username',
                              controller: usernameController,
                              focusNode: usernameFocusNode,
                              focusNodeNext: currentState == "Register"
                                  ? emailFocusNode
                                  : passwordFocusNode),
                          const SizedBox(height: 15),
                          if (currentState == "Register") ...[
                            Field(
                                fieldName: 'Email',
                                controller: emailController,
                                focusNode: emailFocusNode,
                                focusNodeNext: passwordFocusNode),
                            const SizedBox(height: 15),
                            PasswordField(
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              focusNodeNext: confirmPasswordFocusNode,
                              isConfirmPassword: false,
                            ),
                            const SizedBox(height: 15),
                          ],
                          if (currentState == "Login") ...[
                            PasswordField(
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              focusNodeNext: null,
                              isConfirmPassword: false,
                            ),
                            if (errorMessage != null) ...[
                              const SizedBox(height: 15),
                              Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 15),),
                            ],
                            if (isLoading) ...[
                              const SizedBox(height: 15),
                              Center(
                                child: SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator()
                                )
                              ),
                            ],
                            const SizedBox(height: 15),
                            ForgotPasswordButton(
                              onMessageChange: _updateState,
                            ),
                            const SizedBox(height: 15),
                            LoginButton(
                              onPressed: _login,
                            ),
                            const SizedBox(height: 15),
                            RichTextRegister(updateState: _updateState)
                          ] else if (currentState == "Register") ...[
                            PasswordField(
                              controller: confirmPasswordController,
                              focusNode: confirmPasswordFocusNode,
                              focusNodeNext: null,
                              isConfirmPassword: true,
                            ),
                            const SizedBox(height: 15),
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
            ]),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
