import 'dart:io';

import 'package:filmcrate/config/constants/api_endpoint.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/features/profile/presentation/viewmodel/logout_view_model.dart';
import 'package:filmcrate/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/provider/network_connection.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(profileViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Function to reload the data when the user triggers a refresh.
  Future<void> _handleRefresh() async {
    // Implement the logic to reload the data here.
    ref.watch(profileViewModelProvider.notifier).getUserProfile();
  }

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     ref.read(profileViewModelProvider.notifier).fetchUserProfile();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final appWidth = screenSize.width;

    final profileState = ref.watch(profileViewModelProvider);

    Widget buttons(Icon iconss, String title, VoidCallback onPressed) {
      return SizedBox(
        width: isTablet ? 400 : 250,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconss,
              SizedBox(
                width: isTablet ? 20 : 10,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: isTablet ? 24 : 16, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      );
    }

    if (profileState.isLoading) {
      return Scaffold(
        body: Center(
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: const AlwaysStoppedAnimation(0.0),
                curve: Curves.linear,
              ),
            ),
            child: CircularProgressIndicator(
              color: AppColors.bodyColors,
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        toolbarHeight: isTablet ? 110 : 90.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'PROFILE',
            style: TextStyle(
              fontSize: isTablet ? 40 : 38,
            ),
          ),
        ),
      ),
      body: Center(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: FutureBuilder<bool>(
            future: checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final isNetworkConnected = snapshot.data ?? false;

                if (!isNetworkConnected) {
                  // If no internet, show the "No Internet" message.
                  return const Center(
                    child: Text('No Internet Connection'),
                  );
                } else {
                  // If internet is connected, show the ListView.
                  return SingleChildScrollView(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                          padding: isTablet
                              ? const EdgeInsets.fromLTRB(30, 70, 30, 80)
                              : const EdgeInsets.fromLTRB(30, 50, 30, 80),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: isTablet ? 80 : 60.0),
                                  Text(
                                    profileState.user[0].username,
                                    style: TextStyle(
                                      fontFamily: 'Dongle',
                                      fontSize: isTablet ? 55 : 35,
                                    ),
                                  ),
                                  Text(
                                    profileState.user[0].email,
                                    style: TextStyle(
                                      fontSize: isTablet ? 45 : 28.0,
                                      fontFamily: 'Dongle',
                                      fontWeight: FontWeight.w200,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: isTablet ? 30 : 20.0),
                                  buttons(
                                      Icon(
                                        Icons.update,
                                        size: isTablet ? 35 : 24,
                                      ),
                                      'Change Password', () {
                                    Navigator.pushNamed(
                                        context, AppRoute.resetPassword);
                                  }),
                                  SizedBox(
                                    height: isTablet ? 20 : 0,
                                  ),
                                  buttons(
                                      Icon(
                                        Icons.edit,
                                        size: isTablet ? 35 : 24,
                                      ),
                                      'Edit Profile', () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoute.editprofileRoute,
                                      arguments: profileState.user[0].username,
                                    );
                                  }),
                                  SizedBox(
                                    height: isTablet ? 20 : 0,
                                  ),
                                  buttons(
                                      Icon(
                                        Icons.logout_rounded,
                                        size: isTablet ? 35 : 24,
                                      ),
                                      'Logout', () {
                                    ref
                                        .read(logoutViewModelProvider.notifier)
                                        .logout(context);
                                  }),
                                  SizedBox(
                                    height: isTablet ? 20 : 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: appWidth / 2 - (isTablet ? 50.0 : 50.0),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.grey[300],
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          checkCameraPermission();
                                          _browseImage(ref, ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.camera),
                                        label: const Text('Camera'),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          _browseImage(
                                              ref, ImageSource.gallery);
                                          Navigator.pop(context);
                                          ref
                                              .watch(profileViewModelProvider
                                                  .notifier)
                                              .getUserProfile();
                                        },
                                        icon: const Icon(Icons.image),
                                        label: const Text('Gallery'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: isTablet ? 70.0 : 50.0,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              child: ClipOval(
                                child: _img != null
                                    ? Image.file(
                                        _img!,
                                        fit: BoxFit.cover,
                                        width: isTablet ? 140.0 : 100.0,
                                        height: isTablet ? 140.0 : 100.0,
                                      )
                                    : profileState.user[0].image != null
                                        ? Image.network(
                                            // Use Image.network for API-provided image
                                            '${ApiEndpoints.baseUrl}/uploads/${profileState.user[0].image}',
                                            fit: BoxFit.cover,
                                            width: isTablet ? 140.0 : 100.0,
                                            height: isTablet ? 140.0 : 100.0,
                                          )
                                        : Image.asset(
                                            // Show a static image when both _img and API image are null
                                            'images/backgrounds/saitama.jpg',
                                            fit: BoxFit.cover,
                                            width: isTablet ? 140.0 : 100.0,
                                            height: isTablet ? 140.0 : 100.0,
                                          ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
