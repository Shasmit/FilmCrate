// import 'package:filmcrate/config/constants/app_color_theme.dart';
// import 'package:filmcrate/config/router/app_route.dart';
// import 'package:flutter/material.dart';

// class IntroScreenView extends StatefulWidget {
//   const IntroScreenView({Key? key}) : super(key: key);

//   @override
//   State<IntroScreenView> createState() => _IntroScreenViewState();
// }

// class _IntroScreenViewState extends State<IntroScreenView> {
//   Widget texts(String title, FontWeight weights, double sizes) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontWeight: weights,
//           fontFamily: 'Dongle',
//           fontSize: sizes,
//           color: AppColors.bodyColors,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     final screenSize = MediaQuery.of(context).size;
//     final isTablet = screenSize.shortestSide >= 600;
//     return Scaffold(
//       body: Stack(
//         children: [
//           const SizedBox(
//             height: double.infinity,
//             width: double.infinity,
//             child: Image(
//               image: AssetImage('images/backgrounds/top100.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             top: screenHeight / 3,
//             child: Container(
//               height: screenHeight * .7,
//               width: screenWidth,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(20.0)),
//                 color: AppColors.appbarColors,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const AspectRatio(
//                         aspectRatio: 9 / 3,
//                         child: Image(
//                           image: AssetImage('images/backgrounds/filmcrate.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       if (isTablet) ...{
//                         texts("FOR MOVIE LOVERS, BY MOVIE LOVERS",
//                             FontWeight.bold, isTablet ? 60.0 : 40.0),
//                         texts('EXPLORE.', FontWeight.normal,
//                             isTablet ? 45.0 : 35.0),
//                         texts('DISCOVER.', FontWeight.normal,
//                             isTablet ? 45.0 : 35.0),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       },
//                       if (!isTablet) ...{
//                         texts("FOR MOVIE LOVERS,", FontWeight.bold,
//                             isTablet ? 60.0 : 40.0),
//                         texts('EXPLORE.', FontWeight.normal,
//                             isTablet ? 45.0 : 35.0),
//                         texts('DISCOVER.', FontWeight.normal,
//                             isTablet ? 45.0 : 35.0),
//                       },
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
//                         child: SizedBox(
//                           width: double.infinity,
//                           height: isTablet ? 75 : 65.0,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pushNamed(context, AppRoute.loginRoute);
//                             },
//                             child: Text(
//                               'LOGIN',
//                               style: TextStyle(
//                                 fontFamily: 'Dongle',
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 1.2,
//                                 fontSize: isTablet ? 45 : 35.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: isTablet
//                             ? const EdgeInsets.fromLTRB(20, 20, 10, 30)
//                             : const EdgeInsets.fromLTRB(20, 20, 10, 10),
//                         child: SizedBox(
//                           width: double.infinity,
//                           height: isTablet ? 75 : 65.0,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, AppRoute.registerRoute);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: AppColors.bodyColors,
//                               shadowColor: Colors.transparent,
//                             ),
//                             child: Text(
//                               'REGISTER',
//                               style: TextStyle(
//                                 fontFamily: 'Dongle',
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 1.2,
//                                 fontSize: isTablet ? 45 : 35.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
