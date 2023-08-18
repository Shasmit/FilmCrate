import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:filmcrate/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViews extends ConsumerStatefulWidget {
  const RegisterViews({super.key});

  @override
  ConsumerState<RegisterViews> createState() => _RegisterViewsState();
}

class _RegisterViewsState extends ConsumerState<RegisterViews> {
  bool _isObscure = true;
  bool _isObscure1 = true;
  final registerkey = GlobalKey<FormState>();

  SizedBox gap() {
    return const SizedBox(
      height: 5.0,
    );
  }

  SizedBox gapa() {
    return const SizedBox(
      height: 25.0,
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authViewModelProvider);

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
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: double.infinity,
        color: const Color(0xfff6f7d3),
        child: Form(
          key: registerkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 28.0,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.loginRoute);
                    },
                    alignment: Alignment.topLeft,
                  ),
                ),
                const AspectRatio(
                  aspectRatio: 12 / 2.5,
                  child: Image(
                    image: AssetImage('images/backgrounds/filmcrate.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                // gap(),
                padds(
                  'REGISTER',
                  35.0,
                  1.5,
                  const Color(0xff305973),
                  20,
                  0,
                  20,
                  0,
                  0,
                  FontWeight.bold,
                ),
                padds(
                  'JOIN WITH US FOR FULL MASTI',
                  28.0,
                  0.2,
                  const Color(0xff305973),
                  20,
                  10,
                  0,
                  0,
                  0.5,
                  FontWeight.normal,
                ),
                padds(
                  'Username',
                  35.0,
                  1.0,
                  Colors.black,
                  20,
                  10,
                  0,
                  0,
                  0,
                  FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    controller: username,
                    validator: (text) {
                      if (text == null) {
                        return 'Please enter username';
                      }
                      if (text.isEmpty) {
                        return 'Enter an username';
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
                          const EdgeInsets.fromLTRB(25.0, 15.0, 25.00, 15.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your username',
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                gap(),
                padds(
                  'Email',
                  35.0,
                  1.0,
                  Colors.black,
                  20,
                  10,
                  0,
                  0,
                  0,
                  FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    controller: email,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter an email';
                      }
                      const emailPattern =
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                      if (!RegExp(emailPattern).hasMatch(text)) {
                        return 'Invalid email format';
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
                          const EdgeInsets.fromLTRB(25.0, 15.0, 25.00, 15.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                gap(),
                padds(
                  'Password',
                  35.0,
                  1.0,
                  Colors.black,
                  20,
                  10,
                  0,
                  0,
                  0,
                  FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    obscureText: _isObscure,
                    controller: password,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a password';
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
                      contentPadding:
                          const EdgeInsets.fromLTRB(25.0, 15.0, 25.00, 15.0),
                      hintText: 'Enter your password',
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
                padds(
                  'Confirm Password',
                  35.0,
                  1.0,
                  Colors.black,
                  20,
                  10,
                  0,
                  0,
                  0,
                  FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    obscureText: _isObscure1,
                    controller: confirmpass,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a password';
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
                      contentPadding:
                          const EdgeInsets.fromLTRB(25.0, 15.0, 25.00, 15.0),
                      hintText: 'Enter your password',
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
                gapa(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 65.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (registerkey.currentState!.validate()) {
                          var user = UserEntity(
                            username: username.text,
                            email: email.text,
                            password: password.text,
                            confirmPassword: confirmpass.text,
                          );
                          ref
                              .read(authViewModelProvider.notifier)
                              .registerUser(context, user);
                        }
                      },
                      child: const Text(
                        'REGISTER',
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
