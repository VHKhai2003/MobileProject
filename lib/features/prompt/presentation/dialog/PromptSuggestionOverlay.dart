import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/UsingPromptBottomSheet.dart';
import 'package:code/features/prompt/services/PromptApiService.dart';
import 'package:flutter/material.dart';

class ListPrompt extends StatefulWidget {
  const ListPrompt({super.key, required this.onClose, required this.onUsePrompt});
  final VoidCallback onClose;
  final Function(String?) onUsePrompt;
  @override
  State<ListPrompt> createState() => _ListPromptState();
}

class _ListPromptState extends State<ListPrompt> {
  bool hasNext = false;
  int offset = 0;
  List<Prompt> prompts = [];

  void _loadPrompts() async {
    Map<String, dynamic> params = {
      "offset": offset,
      "limit": 20,
      "isPublic": true
    };

    try {
      PromptApiService promptApiService = PromptApiService();
      Map<String, dynamic> data = await promptApiService.getPrompts(params);

      // update state
      setState(() {
        hasNext = data["hasNext"];
        prompts.addAll(
            List<Prompt>.from(
                data["items"].map((item) => Prompt.fromJson(item))
            )
        );
      });
    } catch (e) {
      print('Error when fetching prompt!\n$e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPrompts();
  }

  @override
  Widget build(BuildContext context) {
    int numberOfPrompts = prompts.length;
    return numberOfPrompts == 0 ?
    Center(child: CircularProgressIndicator()) :
    ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
      shrinkWrap: true,
      itemCount: numberOfPrompts + 1,
      itemBuilder: (context, index) {
        if(index == numberOfPrompts) {
          return hasNext ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  offset = offset + 20;
                  _loadPrompts();
                },
                child: Text("More...", style: TextStyle(color: Colors.blue),),
              ),
            ],
          ) : SizedBox.shrink();
        }
        return ListTile(
            title: Text(prompts[index].title),
            onTap: () async {
              widget.onClose();
              String? data = await showModalBottomSheet(context: context, builder: (context) => UsingPromptBottomSheet(prompt: prompts[index]));
              widget.onUsePrompt(data);
            }
        );
      },
    );
  }
}


class PromptSuggestionOverlay {
  BuildContext context;
  VoidCallback onClose;
  Function(String?) onUsePrompt;

  PromptSuggestionOverlay(this.context, this.onClose, this.onUsePrompt);

  OverlayEntry createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // dectect tap event out of the overlay
          GestureDetector(
            onTap: () {
              onClose();
            },
            behavior: HitTestBehavior.opaque, // catch on tap
            child: Container(
              color: Colors.transparent, // Đảm bảo vùng này nhận sự kiện tap
            ),
          ),

          // Overlay thực tế
          Positioned(
            left: offset.dx,
            bottom: 200,
            width: 300,
            height: 300,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              elevation: 4.0,
              child: ListPrompt(onClose: onClose, onUsePrompt: onUsePrompt),
            ),
          ),
        ],
      ),
    );
  }
}
