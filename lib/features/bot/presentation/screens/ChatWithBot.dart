import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import 'package:code/features/bot/provider/RLTBotAndKbProvider.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import '../widgets/ChatAppBar.dart';
import '../widgets/ChatMessages.dart';
import './InputBotBox.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/presentation/screens/ChatBotEmpty.dart';

class ChatWithBot extends StatefulWidget {
  final BotProvider botProvider;
  final Bot bot;

  const ChatWithBot({
    super.key,
    required this.bot,
    required this.botProvider,
  });

  @override
  State<ChatWithBot> createState() => _ChatWithBotState();
}

class _ChatWithBotState extends State<ChatWithBot> {
  Bot? currentBot;
  bool isUpdatingInstruction = false;
  bool showUpdateSuccess = false;
  bool isBotTyping = false;
  Timer? _debounce;
  bool isLoading = false;
  String? currentThreadId;
  final TextEditingController instructionController = TextEditingController();
  final TextEditingController chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _handleNewConversation();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _loadBotDetails();
    if (mounted) {
      await context.read<RLTBotAndKBProvider>().getAssistantKnowledges(
            assistantId: widget.bot.id,
          );
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _loadBotDetails() async {
    try {
      final bot = await widget.botProvider.getBot(widget.bot.id);
      if (mounted) {
        setState(() {
          currentBot = bot;
          instructionController.text = bot.instructions ?? '';
        });
      }
    } catch (e) {
      print('Error loading bot details: $e');
      if (mounted) {
        setState(() => currentBot = null);
      }
    }
  }

  Future<void> _handleInstructionUpdate(String newInstruction) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    setState(() => isUpdatingInstruction = true);

    try {
      final status = await widget.botProvider.updateBot(
        widget.bot.id,
        currentBot!.name,
        newInstruction,
        currentBot!.description,
      );

      if (status && mounted) {
        widget.botProvider.clearListBot();
        widget.botProvider.loadBots('');
        await _loadBotDetails();
      }
    } catch (e) {
      print('Error updating instructions: $e');
    } finally {
      if (mounted) {
        setState(() => isUpdatingInstruction = false);
      }
    }
  }

  void _handleInstructionCancel() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() => isUpdatingInstruction = false);
  }

  Future<void> _handleMessageSend(
      String message, String threadId, String instruction) async {
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message cannot be empty')),
      );
      return;
    }

    final threadProvider = context.read<ThreadBotProvider>();
    bool isNewThread = currentThreadId == null;
    String activeThreadId = currentThreadId ?? '';

    threadProvider.addMessage(
      content: message,
      isBot: false,
      threadId: activeThreadId,
    );
    chatController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    setState(() => isBotTyping = true);

    if (isNewThread) {
      try {
        final newThreadId = await threadProvider.createThread(
          assistantId: widget.bot.id,
          firstMessage: message,
        );

        if (newThreadId == null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to create new thread')),
            );
          }
          setState(() => isBotTyping = false);
          return;
        }

        activeThreadId = newThreadId;
        if (mounted) {
          setState(() => currentThreadId = newThreadId);
        }
      } catch (e) {
        print('Error creating new thread: $e');
        setState(() => isBotTyping = false);
        return;
      }
    }

    final response = await threadProvider.askAssistant(
      widget.bot.id,
      message: message,
      threadId: activeThreadId,
      additionalInstruction: instruction,
    );

    if (mounted) {
      setState(() {
        isBotTyping = false;
        if (response != null) {
          threadProvider.addMessage(
            content: response,
            isBot: true,
            threadId: activeThreadId,
          );
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  Future<void> _switchThread(String threadId) async {
    setState(() => isLoading = true);

    try {
      final threadProvider = context.read<ThreadBotProvider>();
      setState(() => currentThreadId = threadId);
      await threadProvider.getThreadMessages(threadId);
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      print('Error switching thread: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error loading chat history')),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _handleNewConversation() {
    final threadProvider = context.read<ThreadBotProvider>();
    setState(() {
      currentThreadId = null;
      threadProvider.clearMessages();
    });
    chatController.clear();
    instructionController.clear();
    _loadBotDetails();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    instructionController.dispose();
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);
    final threadProvider = Provider.of<ThreadBotProvider>(context);

    if (currentBot == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(
        botName: currentBot!.name,
        tokenUsage: tokenUsageProvider.tokenUsage,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ThreadBotProvider>(
              builder: (context, provider, _) {
                if (provider.messages.isEmpty) {
                  return EmptyChat(
                    botName: currentBot!.name,
                    chatController: chatController,
                  );
                } else {
                  return ChatMessages(
                    scrollController: _scrollController,
                    messages: provider.messages,
                    isLoading: isLoading,
                    isBotTyping: isBotTyping,
                    botName: currentBot!.name,
                  );
                }
              },
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InputBotBox(
              changeConversation: _handleNewConversation,
              listKnownledge: currentBot?.knowledge ?? [],
              botId: widget.bot.id,
              instructionController: instructionController,
              chatController: chatController,
              isUpdating: isUpdatingInstruction,
              showSuccess: showUpdateSuccess,
              onInstructionChange: _handleInstructionUpdate,
              onSendMessage: _handleMessageSend,
              onViewThreadList: (assistantId) async {
                await threadProvider.getThreads(assistantId: assistantId);
              },
              onViewMessages: _switchThread,
              currentThreadId: currentThreadId,
              onCancelInstruction: _handleInstructionCancel,
            ),
          ),
        ],
      ),
    );
  }
}
