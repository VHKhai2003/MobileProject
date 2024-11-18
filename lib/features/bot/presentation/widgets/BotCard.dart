// import 'package:flutter/material.dart';

// class BotCard extends StatefulWidget {
//   final String name;
//   final String description;
//   final String date;
//   final bool isFavorite;
//   final VoidCallback? onFavorite;
//   final VoidCallback? onDelete;
//   final VoidCallback? onTap;

//   const BotCard({
//     required this.name,
//     required this.description,
//     required this.date,
//     this.isFavorite = false,
//     this.onFavorite,
//     this.onDelete,
//     this.onTap,
//   });

//   @override
//   _BotCardState createState() => _BotCardState();
// }

// class _BotCardState extends State<BotCard> {
//   late bool _isFavorite;

//   @override
//   void initState() {
//     super.initState();
//     _isFavorite = widget.isFavorite;
//   }

//   void _toggleFavorite() {
//     setState(() {
//       _isFavorite = !_isFavorite;
//     });
//     if (widget.onFavorite != null) {
//       widget.onFavorite!();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 3,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(Icons.android, size: 40, color: Colors.blue),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     widget.name,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           _isFavorite ? Icons.star : Icons.star_border,
//                           color: _isFavorite ? Colors.yellowAccent : null,
//                         ),
//                         onPressed: _toggleFavorite,
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: widget.onDelete != null
//                             ? () => widget.onDelete!()
//                             : null,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               if (widget.description.isNotEmpty)
//                 Text(
//                   widget.description,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//               SizedBox(height: 8),
//               Text(
//                 widget.date,
//                 style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BotCard extends StatefulWidget {
  final String name;
  final String description;
  final String date;
  final bool isFavorite;
  final VoidCallback? onFavorite;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final VoidCallback? onPublish; // Add this parameter

  const BotCard({
    required this.name,
    required this.description,
    required this.date,
    this.isFavorite = false,
    this.onFavorite,
    this.onDelete,
    this.onTap,
    this.onPublish, // Add this parameter
  });

  @override
  _BotCardState createState() => _BotCardState();
}

class _BotCardState extends State<BotCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (widget.onFavorite != null) {
      widget.onFavorite!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.android, size: 40, color: Colors.blue),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isFavorite ? Icons.star : Icons.star_border,
                          color: _isFavorite ? Colors.yellowAccent : null,
                        ),
                        onPressed: _toggleFavorite,
                      ),
                      IconButton(
                        icon: Icon(Icons.cloud),
                        onPressed: widget.onPublish != null
                            ? () => widget.onPublish!()
                            : null,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: widget.onDelete != null
                            ? () => widget.onDelete!()
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (widget.description.isNotEmpty)
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              SizedBox(height: 8),
              Text(
                widget.date,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
