import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../services/camera.service.dart';
import '../models/user.model.dart';
import '../profile.dart';
import 'app_button.dart';
import 'app_text_field.dart';

class SignInSheet extends StatelessWidget {
  SignInSheet({Key? key, required this.user}) : super(key: key);
  final User user;

  final _cameraService = locator<CameraService>();

  Future _signIn(context, user) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Profile(
                  user.user,
                  imagePath: _cameraService.imagePath!,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Welcome back, ' + user.user + '.',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height:10,),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    AppButton(
                      text: 'LOGIN',
                      onPressed: () async {
                        _signIn(context, user);
                      },
                      icon: Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
