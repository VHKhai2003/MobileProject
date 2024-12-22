import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:code/features/chat/providers/ChatProvider.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:code/features/chat/presentation/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:code/shared/widgets/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/features/chat/presentation/chatbox/ChatBox.dart';
import 'package:code/features/chat/presentation/EmptyConversation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FocusNode promptFocusNode = FocusNode();
  final TextEditingController promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // ads
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  Future<void> loadAds() async {
    await Future.delayed(Duration(seconds: 10));
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    loadAds();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    promptController.dispose();
    promptFocusNode.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }
  // end ads

  bool isEmpty = true;
  void _handleNewChat() {
    setState(() {
      isEmpty = true;
    });
  }
  void _handleOpenConversation() {
    setState(() {
      isEmpty = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AiModelProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider(context.read<TokenUsageProvider>())),
        ChangeNotifierProvider(create:
          (context) => ConversationsProvider(
            context.read<ChatProvider>(),
            context.read<AiModelProvider>(),
            context.read<ThreadBotProvider>()
          )
        ),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          promptFocusNode.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: buildActions(context, tokenUsageProvider.tokenUsage),
          ),
          drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    isEmpty ?
                    EmptyConversation(
                      changeConversation: _handleOpenConversation,
                      promptController: promptController,
                    ) :
                    Expanded(child: Conversation(isConversationHistory: isEmpty, scrollController: _scrollController,)),
                    Chatbox(
                      isNewChat: isEmpty,
                      changeConversation: _handleOpenConversation,
                      openNewChat: _handleNewChat,
                      promptFocusNode: promptFocusNode,
                      promptController: promptController,
                      scrollController: _scrollController,
                    ),
                  ],
                ),
              ),
              if (_isAdLoaded) ...[
                Positioned(
                  top: 0,
                  left: 50,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isAdLoaded = false;
                            });
                            await loadAds();
                          },
                          child: Container(
                            color: Colors.white,
                            child: Icon(Icons.clear, color: Colors.blue, size: 20,)
                          )
                        )
                      )
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
