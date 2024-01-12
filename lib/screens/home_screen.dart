import 'package:flutter/material.dart';
import 'package:test_login/helpers/login_helper.dart';
import 'package:test_login/models/my_user.dart';
import 'package:test_login/widgets/extra_login_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late MyUser? _myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            surfaceTintColor: Colors.white,
            shadowColor: Colors.blueGrey,
            enableFeedback: true,
            offset: const Offset(0, 50.0),
            onSelected: (value) {
              if (value == 'logout') {
                LoginHelper.facebookLogOut().then((value) => {
                      setState(() {
                        _myUser = null;
                      })
                    });
              }
            },
            itemBuilder: (BuildContext context) {
              return _buildMenuItems();
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      body: Center(
        child: ExtraLoginOptions(
          successLogin: (myUser) {
            setState(() {
              _myUser = myUser;
            });
          },
        ),
      ),
    );
  }

  List<PopupMenuItem> _buildMenuItems() {
    List<PopupMenuItem> list = [];

    if (_myUser != null) {
      list.add(PopupMenuItem(
        value: _myUser,
        child: Row(
          children: [
            ClipOval(
              child:
                  Image.network(_myUser!.imageUrl, width: 30.0, height: 30.0),
            ),
            const SizedBox(width: 10.0),
            Text(_myUser!.name),
          ],
        ),
      ));
      list.add(const PopupMenuItem(
        value: 'logout',
        child: Text('logout'),
      ));
    } else {
      list = [];
    }
    return list;
  }
}
