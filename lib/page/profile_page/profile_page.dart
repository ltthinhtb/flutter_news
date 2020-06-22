import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/authentication_page/authetication_page.dart';
import 'package:flutter_news/page/profile_page/profile.dart';

import 'package:flutter_news/page/recent_list_news/recent_list_news.dart';
import 'package:flutter_news/page/save_list_news/save_list_news.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_page.dart';
import 'package:flutter_news/service/auth_service.dart';
import 'package:flutter_news/theme_bloc/chang_theme.dart';
import 'package:share/share.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileSettingBloc _bloc;
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    _bloc = ProfileSettingBloc();
    _bloc..add(LoadProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
        builder: (context, state) {
          if (state is DataSuccessState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          'assets/background.png',
                          fit: BoxFit.cover,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                            ),
                            state.user == null
                                ? Center(
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 50,
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                      ),
                                    ),
                                )
                                : (state.user.photoUrl == null
                                    ? CircleAvatar(
                                        radius: 50,
                                        child: InkWell(
                                          onTap: () {
                                            _showDialog(context);
                                          },
                                          child: Icon(
                                            Icons.person,
                                            size: 70,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        child: InkWell(
                                          onTap: () {
                                            _showDialog(context);
                                          },
                                        ),
                                        radius: 50,
                                        backgroundImage:
                                            NetworkImage(state.user.photoUrl),
                                      )),
                            state.user != null
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.user.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AuthenticationPage()));
                                        },
                                        child: Text('Đăng nhập',
                                          style: TextStyle(
                                              color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpPage()));
                                        },
                                        child: Text('Đăng ký',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'HOẠT ĐỘNG',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              onTap: () {
                                if (state.user == null)
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Bạn cần đăng nhập.'),
                                    duration: Duration(seconds: 3),
                                  ));
                                else
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          RecentListNewPage()));
                              },
                              title: Text('Tin đã xem'),
                              trailing: Icon(Icons.chevron_right),
                              leading: Icon(Icons.update),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              onTap: () {
                                if (state.user == null)
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Bạn cần đăng nhập.'),
                                    duration: Duration(seconds: 3),
                                  ));
                                else
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SaveListNewPage()));
                              },
                              title: Text('Tin yêu thích'),
                              trailing: Icon(Icons.chevron_right),
                              leading: Icon(Icons.bookmark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'TÙY CHỈNH',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              title: Text('Chế độ tối'),
                              trailing: Switch(
                                value: _bloc.optionValue == null
                                    ? false
                                    : _bloc.optionValue,
                                onChanged: (value) {
                                  _bloc.optionValue = value;
                                  BlocProvider.of<ChangeThemeBloc>(context)
                                      .add(ChooseThemeEvent());
                                },
                                activeTrackColor: Colors.blue,
                                activeColor: Colors.grey,
                              ),
                              leading: Icon(Icons.wb_sunny),
                            ),
                          ),
                          Visibility(
                            visible: _bloc.isLogin,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ListTile(
                                onTap: () {
                                  BlocProvider.of<ProfileSettingBloc>(context)
                                      .add(LogOut());
                                },
                                title: Text('Đăng xuất'),
                                leading: Icon(Icons.exit_to_app),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Ảnh đại diện"),
            actions: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Thư viện"),
                    onPressed: () {
                      _bloc.add(UpdateAvatarEvent(false));
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("Máy Ảnh"),
                    onPressed: () {
                      _bloc.add(UpdateAvatarEvent(true));
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();

    Share.share("url",
        subject: "alligator.description",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
