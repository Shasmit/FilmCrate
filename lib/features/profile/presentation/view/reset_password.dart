import 'package:filmcrate/features/profile/domain/entity/password_entity.dart';
import 'package:filmcrate/features/profile/presentation/viewmodel/password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({super.key});

  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
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
                  aspectRatio: 12 / 2,
                  child: Image(
                    image: AssetImage('images/backgrounds/filmcrate.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                gap(),
                padds('UPDATE PASSWORD', 35.0, 1.5, const Color(0xff305973), 20,
                    0, 20, 0, 0, FontWeight.bold),
                gap(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    padds('Current password', 35.0, 0, Colors.black, 20, 10, 0,
                        0, 0, FontWeight.normal),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: TextFormField(
                        obscureText: _isObscure,
                        controller: currentPassword,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Password doesn't match";
                          }
                          if (text.length < 8) {
                            return 'Password should be at least 8 characters long';
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
                          contentPadding: const EdgeInsets.fromLTRB(
                              25.0, 20.0, 25.00, 20.0),
                          hintText: "Enter current password...",
                          hintStyle: const TextStyle(
                            fontSize: 15.0,
                          ),
                          suffixIcon: Align(
                            widthFactor: 1.5,
                            heightFactor: 1.0,
                            child: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                          ),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
                    gap(),
                    padds('New password', 35.0, 0, Colors.black, 20, 10, 0, 0,
                        0, FontWeight.normal),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: TextFormField(
                        obscureText: _isObscure1,
                        controller: newPassword,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Password doesn't match";
                          }
                          if (text.length < 8) {
                            return 'Password should be at least 8 characters long';
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
                          contentPadding: const EdgeInsets.fromLTRB(
                              25.0, 20.0, 25.00, 20.0),
                          hintText: "Enter new password...",
                          hintStyle: const TextStyle(
                            fontSize: 15.0,
                          ),
                          suffixIcon: Align(
                            widthFactor: 1.5,
                            heightFactor: 1.0,
                            child: IconButton(
                                icon: Icon(
                                  _isObscure1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
                                  });
                                }),
                          ),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
                    gap(),
                    padds('Confirm new password', 35.0, 0, Colors.black, 20, 10,
                        0, 0, 0, FontWeight.normal),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: TextFormField(
                        obscureText: _isObscure2,
                        controller: confirmPassword,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Password doesn't match";
                          }
                          if (text.length < 8) {
                            return 'Password should be at least 8 characters long';
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
                          contentPadding: const EdgeInsets.fromLTRB(
                              25.0, 20.0, 25.00, 20.0),
                          hintText: "Enter new password again...",
                          hintStyle: const TextStyle(
                            fontSize: 15.0,
                          ),
                          suffixIcon: Align(
                            widthFactor: 1.5,
                            heightFactor: 1.0,
                            child: IconButton(
                                icon: Icon(
                                  _isObscure2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                          ),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
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
                                  .read(passwordViewModelProvider.notifier)
                                  .changePassword(
                                    PasswordEntity(
                                      oldPassword: currentPassword.text,
                                      newPassword: newPassword.text,
                                      confirmPassword: confirmPassword.text,
                                    ),
                                    context,
                                  );

                              confirmPassword.clear();
                              newPassword.clear();
                              currentPassword.clear();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
