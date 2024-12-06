import 'package:code/data/apis/ApiService.dart';
import 'package:code/features/auth/presentation/LoginPage.dart';
import 'package:code/features/auth/providers/AuthProvider.dart';
import 'package:code/features/chat/presentation/ChatPage.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ApiService apiService = ApiService();
  await apiService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenUsageProvider(apiService)),
        ChangeNotifierProvider(create: (context) => AuthProvider(context.read<TokenUsageProvider>())),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0, // Xóa bóng đổ
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 25, 118, 210), // Màu nền status bar
            statusBarIconBrightness: Brightness.dark, // Màu icon status bar
          ),
        ),
      ),
      home: tokenUsageProvider.isAuthenticated ? ChatPage() : LoginPage(state: "Login"),
      debugShowCheckedModeBanner: false,
    );
  }
}