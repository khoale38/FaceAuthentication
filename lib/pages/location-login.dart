import 'package:flutter/material.dart';
import 'package:untitled1/pages/profile.dart';
import 'package:untitled1/pages/widgets/app_button.dart';
import 'package:untitled1/pages/widgets/app_text_field.dart';

import 'db/databse_helper.dart';
import 'models/user.model.dart';

class LocationLogin extends StatefulWidget {
  const LocationLogin({Key? key}) : super(key: key);

  @override
  State<LocationLogin> createState() => _LocationLoginState();
}

class _LocationLoginState extends State<LocationLogin> {
  final TextEditingController _userTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController =
      TextEditingController(text: '');

  Future<User?> locationLogin() async {
    DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
    final user = await _dataBaseHelper.findUser(
        _userTextEditingController.value.text,
        _passwordTextEditingController.value.text);
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Location Login',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              child: Column(
                children: [
                  AppTextField(
                    controller: _userTextEditingController,
                    labelText: "Your Name",
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    controller: _passwordTextEditingController,
                    labelText: "Password",
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  AppButton(
                    text: 'LOGIN',
                    onPressed: () async {
                      final value = await locationLogin();
                      if (!mounted) return;
                      value != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Profile(
                                        value.user,
                                        imagePath: value.image,
                                      )))
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('No User found!'),
                                );
                              },
                            );
                    },
                    icon: const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
