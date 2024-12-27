import 'dart:async';
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

import 'core/utils/event_bus.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.updateRequestConfiguration(
  //   RequestConfiguration(testDeviceIds: ['D67BE787D86284D785329A057D33F657']), // Thay bằng Test Device ID thực tế
  // );
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
  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<TokenRefreshFailedEvent>().listen((event) {
      _handleTokenRefreshFailed();
    });
  }

  void _handleTokenRefreshFailed() {
    navigatorKey.currentState?.pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LoginPage(state: "Login"),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
          const end = Offset.zero; // Kết thúc tại vị trí gốc
          const curve = Curves.easeInOut; // Hiệu ứng chuyển cảnh
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider =
        Provider.of<TokenUsageProvider>(context, listen: false);

    return MaterialApp(
      navigatorKey: navigatorKey,
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
