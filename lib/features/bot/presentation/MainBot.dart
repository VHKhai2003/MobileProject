// import 'package:code/shared/providers/TokenUsageProvider.dart';
// import 'package:code/shared/widgets/appbar/BuildActions.dart';
// import 'package:flutter/material.dart';
// import 'package:code/features/bot/presentation/widgets/BotCard.dart';
// import 'package:code/shared/widgets/drawer/NavigationDrawer.dart'
//     as navigation_drawer;
// import 'package:code/features/bot/presentation/screens/BotDashboard.dart';
// import 'package:code/features/bot/presentation/dialog/CreateBotDiaLog.dart';
// import 'package:code/features/bot/presentation/dialog/UpdateBotDiaLog.dart';
// import 'package:code/features/bot/presentation/dialog/DeleteBotDialog.dart';
// import 'package:code/features/bot/presentation/screens/ChatWithBot.dart';
// import 'package:code/features/bot/models/Bot.dart';
// import 'package:provider/provider.dart';
// import 'package:code/features/bot/provider/BotProvider.dart';

// class MainBot extends StatefulWidget {
//   @override
//   State<MainBot> createState() => _MainBotState();
// }

// class _MainBotState extends State<MainBot> {
//   String searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<BotProvider>().loadBots('');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);
//     final botProvider = Provider.of<BotProvider>(context);

//     List<Bot> filteredBots = searchQuery.isEmpty
//         ? botProvider.bots
//         : botProvider.bots
//             .where((bot) =>
//                 bot.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
//                 (bot.description?.toLowerCase() ?? '')
//                     .contains(searchQuery.toLowerCase()))
//             .toList();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEBEFFF),
//         actions: buildActions(context, tokenUsageProvider.tokenUsage),
//       ),
//       drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             BotDashboard(
//               onBotTypeChanged: (type) {},
//               onSearch: (query) {
//                 setState(() {
//                   searchQuery = query;
//                 });
//               },
//               onCreateBot: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) =>
//                       CreateBotDialog(botProvider: botProvider),
//                 );
//               },
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: botProvider.isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : ListView.builder(
//                       itemCount: filteredBots.length,
//                       itemBuilder: (context, index) {
//                         final bot = filteredBots[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 16.0),
//                           child: BotCard(
//                             name: bot.name,
//                             description: bot.description ?? '',
//                             createdAt: bot.createdAt,
//                             updatedAt: bot.updatedAt,
//                             onEdit: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => UpdateBotDialog(
//                                   botProvider: botProvider,
//                                   bot: bot,
//                                 ),
//                               );
//                             },
//                             onPublish: () {},
//                             onDelete: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => DeleteBotDialog(
//                                   botProvider: botProvider,
//                                   bot: bot,
//                                 ),
//                               );
//                             },
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ChatWithBot(
//                                     botProvider: botProvider,
//                                     bot: bot,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';
import 'package:code/features/bot/presentation/widgets/BotCard.dart';
import 'package:code/shared/widgets/drawer/NavigationDrawer.dart'
    as navigation_drawer;
import 'package:code/features/bot/presentation/screens/BotDashboard.dart';
import 'package:code/features/bot/presentation/dialog/CreateBotDiaLog.dart';
import 'package:code/features/bot/presentation/dialog/UpdateBotDiaLog.dart';
import 'package:code/features/bot/presentation/dialog/DeleteBotDialog.dart';
import 'package:code/features/bot/presentation/screens/ChatWithBot.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/BotProvider.dart';

class MainBot extends StatefulWidget {
  @override
  State<MainBot> createState() => _MainBotState();
}

class _MainBotState extends State<MainBot> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadBots();
  }

  Future<void> _loadBots() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BotProvider>().loadBots('');
    });
  }

  Future<void> _navigateToChatWithBot(
      BuildContext context, BotProvider botProvider, Bot bot) async {
    // Sử dụng Navigator.push và đợi kết quả khi quay lại
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatWithBot(
          botProvider: botProvider,
          bot: bot,
        ),
      ),
    );

    // Khi người dùng quay lại (nhấn nút back), load lại danh sách bot
    if (result == true || result == null) {
      await _loadBots();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);
    final botProvider = Provider.of<BotProvider>(context);

    List<Bot> filteredBots = searchQuery.isEmpty
        ? botProvider.bots
        : botProvider.bots
            .where((bot) =>
                bot.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                (bot.description?.toLowerCase() ?? '')
                    .contains(searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        actions: buildActions(context, tokenUsageProvider.tokenUsage),
      ),
      drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BotDashboard(
              onBotTypeChanged: (type) {},
              onSearch: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              onCreateBot: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      CreateBotDialog(botProvider: botProvider),
                );
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: botProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredBots.length,
                      itemBuilder: (context, index) {
                        final bot = filteredBots[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: BotCard(
                            name: bot.name,
                            description: bot.description ?? '',
                            createdAt: bot.createdAt,
                            updatedAt: bot.updatedAt,
                            onEdit: () {
                              showDialog(
                                context: context,
                                builder: (context) => UpdateBotDialog(
                                  botProvider: botProvider,
                                  bot: bot,
                                ),
                              );
                            },
                            onPublish: () {},
                            onDelete: () {
                              showDialog(
                                context: context,
                                builder: (context) => DeleteBotDialog(
                                  botProvider: botProvider,
                                  bot: bot,
                                ),
                              );
                            },
                            onTap: () {
                              _navigateToChatWithBot(context, botProvider, bot);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
