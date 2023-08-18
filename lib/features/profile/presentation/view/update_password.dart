import 'package:filmcrate/config/router/app_route.dart';
import 'package:flutter/material.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  TextEditingController email = TextEditingController();
  bool ismailSent = false;

  @override
  void dispose() {
    email.dispose();
    super.dispose();
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
                padds('UPDATE PASSWORD', 35.0, 1.5, const Color(0xff305973), 20,
                    0, 20, 0, 0, FontWeight.bold),
                padds(
                    'FORGOT YOUR PASSWORD??',
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
                gap(),
                gap(),
                Column(
                  children: [
                    padds('Enter Your Email', 35.0, 0, Colors.black, 20, 10, 0,
                        0, 0, FontWeight.normal),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: TextFormField(
                        controller: email,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter an email';
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
                          contentPadding: const EdgeInsets.fromLTRB(
                              25.0, 20.0, 25.00, 20.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter email..',
                          hintStyle: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
                    gap(),
                    if (ismailSent == true) ...{
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "We've sent you a verification mail.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    },
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
                              Navigator.pushNamed(
                                  context, AppRoute.resetPassword);
                              email.clear();
                            }
                            setState(() {
                              ismailSent = true;
                            });
                          },
                          child: const Text(
                            'VERIFY',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
