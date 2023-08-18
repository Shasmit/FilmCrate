import 'package:filmcrate/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    super.dispose();
  }

  String? users;

  @override
  void didChangeDependencies() {
    users = ModalRoute.of(context)!.settings.arguments as String?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final pinkey = GlobalKey<FormState>();

    SizedBox gap() {
      return const SizedBox(
        height: 15.0,
      );
    }

    Widget padds(
        String title,
        double fonts,
        double letters,
        Color textcolor,
        double left,
        double right,
        double top,
        double bottom,
        double wordSpace,
        FontWeight weight) {
      return Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Dongle',
            fontSize: fonts,
            fontWeight: weight,
            letterSpacing: letters,
            wordSpacing: wordSpace,
            color: textcolor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        width: double.infinity,
        color: const Color(0xfff6f7d3),
        child: Form(
          key: pinkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AspectRatio(
                  aspectRatio: 12 / 3,
                  child: Image(
                    image: AssetImage('images/backgrounds/filmcrate.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                gap(),
                padds('EDIT PROFILE', 35.0, 1.5, const Color(0xff305973), 20, 0,
                    20, 0, 0, FontWeight.bold),
                padds(
                    'UPDATE YOUR USERNAME & EMAIL',
                    28.0,
                    0.2,
                    const Color(0xff305973),
                    20,
                    10,
                    0,
                    0,
                    0.5,
                    FontWeight.normal),
                gap(),
                padds('Username', 35.0, 1.0, Colors.black, 20, 10, 0, 0, 0,
                    FontWeight.w500),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    controller: username,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter an username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      contentPadding:
                          const EdgeInsets.fromLTRB(25.0, 20.0, 25.00, 20.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: users,
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                gap(),
                padds('Email', 35.0, 1.0, Colors.black, 20, 10, 0, 0, 0,
                    FontWeight.w500),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    controller: email,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Enter your email";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.fromLTRB(25.0, 20.0, 25.00, 20.0),
                      hintText: "Enter new email",
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                gap(),
                gap(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 65.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (pinkey.currentState!.validate()) {
                          ref
                              .read(profileViewModelProvider.notifier)
                              .editProfile(username.text, email.text, context);

                          ref
                              .watch(profileViewModelProvider.notifier)
                              .getUserProfile();
                          username.clear();
                          email.clear();
                        }
                      },
                      child: const Text(
                        'UPDATE',
                        style: TextStyle(
                          fontFamily: 'Dongle',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          fontSize: 35.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
