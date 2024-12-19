import 'package:code/data/apis/ApiService.dart';
import 'package:code/features/auth/presentation/LoginPage.dart';
import 'package:code/features/auth/providers/AuthProvider.dart';
import 'package:code/features/chat/presentation/ChatPage.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/provider/RLTBotAndKbProvider.dart';
import 'package:code/features/bot/provider/ThreadBotProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  final ApiService apiService = ApiService();
  await apiService.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TokenUsageProvider(apiService)),
      ChangeNotifierProvider(
          create: (context) =>
              AuthProvider(context.read<TokenUsageProvider>())),
      ChangeNotifierProvider(create: (_) => BotProvider()),
      ChangeNotifierProvider(create: (_) => RLTBotAndKBProvider()),
      ChangeNotifierProvider(create: (_) => ThreadBotProvider()),
    ],
    child: const MyApp(),
  ));
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
            statusBarColor:
                Color.fromARGB(255, 25, 118, 210), // Màu nền status bar
            statusBarIconBrightness: Brightness.dark, // Màu icon status bar
          ),
        ),
      ),
      home: tokenUsageProvider.isAuthenticated
          ? ChatPage()
          : LoginPage(state: "Login"),
      debugShowCheckedModeBanner: false,
    );
  }
}
