// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import '../../../../config/constants/app_color_theme.dart';

// class SliverAppBars extends StatefulWidget {
//   final String backgroundCover;
//   const SliverAppBars(this.backgroundCover, {super.key});

//   @override
//   State<SliverAppBars> createState() => _SliverAppBarsState();
// }

// class _SliverAppBarsState extends State<SliverAppBars> {
//   bool isVideoPlaying = false;
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: 'uRu3zLOJN2c',
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     );
//     _controller.reload();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void toggleVideoState() {
//     setState(() {
//       isVideoPlaying = !isVideoPlaying;
//     });
//     if (isVideoPlaying) {
//       _controller.play();
//     } else {
//       _controller.pause();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final isTablet = screenSize.shortestSide >= 600;
//     return SliverAppBar(
//       backgroundColor: Colors.white,
//       expandedHeight: isTablet ? 300 : 225.0,
//       flexibleSpace: GestureDetector(
//         onTap: toggleVideoState,
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Image.network(
//                 widget.backgroundCover,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             if (isVideoPlaying)
//               Positioned.fill(
//                 child: YoutubePlayerBuilder(
//                   player: YoutubePlayer(
//                     controller: _controller,
//                     showVideoProgressIndicator: true,
//                   ),
//                   builder: (context, player) {
//                     return player;
//                   },
//                 ),
//               ),
//             Align(
//               alignment: Alignment.center,
//               child: IconButton(
//                 icon: Icon(
//                   isVideoPlaying ? Icons.pause : Icons.play_circle_fill_rounded,
//                   size: 60.0,
//                   color: AppColors.bodyColors,
//                 ),
//                 onPressed: toggleVideoState,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SliverAppBars extends StatelessWidget {
  final String backgroundCover;
  const SliverAppBars(this.backgroundCover, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: isTablet ? 300 : 225.0,
      flexibleSpace: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Image.network(
          backgroundCover,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
