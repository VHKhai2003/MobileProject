import 'package:code/features/auth/presentation/components/HorizontalLine.dart';
import 'package:code/features/auth/presentation/components/JarvisLogoAndLabel.dart';
import 'package:code/features/auth/presentation/components/PrivacyPolicy.dart';
import 'package:code/features/auth/presentation/components/RichTextLogin.dart';
import 'package:code/features/auth/presentation/components/RichTextRegister.dart';
import 'package:flutter/material.dart';
import 'package:code/features/auth/presentation/buttons/LoginButton.dart';
import 'package:code/features/auth/presentation/buttons/RegisterButton.dart';
import 'package:code/features/auth/presentation/buttons/ResetPasswordButton.dart';
import 'package:code/features/auth/presentation/buttons/SignInWithGoogleButton.dart';
import 'package:code/features/auth/presentation/buttons/SwitchLoginButton.dart';
import 'package:code/features/auth/presentation/buttons/ForgotPasswordButton.dart';
import 'package:code/features/auth/presentation/fields/Field.dart';
import 'package:code/features/auth/presentation/fields/PasswordField.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

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

  Future<void> _login() async {
    final String apiUrl =
        'https://api.dev.jarvis.cx/api/v1/auth/sign-in'; // Thay bằng URL API của bạn

    // Kiểm tra input
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      _showErrorDialog("Username và Password không được để trống.");
      return;
    }

    // Tạo payload
    final Map<String, dynamic> payload = {
      'email': usernameController.text,
      'password': passwordController.text,
    };

    try {
      final dio = Dio();
      final response = await dio.post(
        apiUrl,
        data: jsonEncode(payload),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        // Xử lý phản hồi
        final data = response.data;
        _showSuccessDialog("Đăng nhập thành công!");
        print("Response Data: $data");
      } else {
        _showErrorDialog(
            "Đăng nhập thất bại. Vui lòng kiểm tra lại thông tin.");
      }
    } catch (e) {
      print("Request failed: $e");
      _showErrorDialog("Có lỗi xảy ra khi gửi yêu cầu.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Lỗi"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thành công"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
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
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.grey,
              )),
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
