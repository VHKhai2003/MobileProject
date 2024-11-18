import 'package:code/features/profile/presentation/account/CancelButton.dart';
import 'package:code/features/profile/presentation/account/SaveChangeButton.dart';
import 'package:code/features/profile/presentation/account/fields/PasswordField.dart';
import 'package:flutter/material.dart';
import 'package:code/features/profile/presentation/account/ChangePasswordButton.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  late bool isChange = false;

  void changePassword(bool value) {
    setState(() {
      isChange = value;
    });
  }

  @override
  void initState() {
    super.initState();
    oldPasswordFocusNode.addListener(() {
      if (oldPasswordFocusNode.hasFocus) {
        _scrollToFocusedField(oldPasswordFocusNode);
      }
    });
    newPasswordFocusNode.addListener(() {
      if (newPasswordFocusNode.hasFocus) {
        _scrollToFocusedField(newPasswordFocusNode);
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

  @override
  void dispose() {
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEBEFFF),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: TextEditingController(text: 'nqhuy'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                prefixIcon: const Icon(Icons.account_circle_outlined),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: 'ngoquochuy9g@gmail.com'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Column(
                children: [
                  if (isChange) ...[
                    const SizedBox(height: 10),
                    PasswordField(
                      focusNode: oldPasswordFocusNode,
                      focusNodeNext: newPasswordFocusNode,
                      fieldName: "Old password",
                    ),
                    const SizedBox(height: 5),
                    PasswordField(
                      focusNode: newPasswordFocusNode,
                      focusNodeNext: confirmPasswordFocusNode,
                      fieldName: "New password",
                    ),
                    const SizedBox(height: 5),
                    PasswordField(
                      focusNode: confirmPasswordFocusNode,
                      focusNodeNext: null,
                      fieldName: "Confirm password",
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: CancelButton(onChangePassword: changePassword)
                        ),
                        const Expanded(
                            child: SaveChangeButton()
                        ),
                      ],
                    )
                  ] else ...[
                    const SizedBox(height: 15),
                    ChangePasswordButton(onChangePassword: changePassword)
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



