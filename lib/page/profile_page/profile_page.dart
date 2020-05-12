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
              body: ListView(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        state.user == null
                            ? CircleAvatar(
                                radius: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 60,
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
                                        size: 60,
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
                        SizedBox(
                          height: 20,
                        ),
                        state.user != null
                            ? Text(state.user.name)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    color: Colors.grey,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AuthenticationPage()));
                                    },
                                    child: Text('Đăng nhập'),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FlatButton(
                                    color: Colors.grey,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage()));
                                    },
                                    child: Text('Đăng ký'),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('HOẠT ĐỘNG'),
                  ),
                  ListTile(
                    onTap: () {
                      if (state.user == null)
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Bạn cần đăng nhập.'),
                          duration: Duration(seconds: 3),
                        ));
                      else
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecentListNewPage()));
                    },
                    title: Text('Tin đã xem'),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.refresh),
                  ),
                  ListTile(
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
                    leading: Icon(Icons.book),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('TÙY CHỈNH'),
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text('Chế độ tối'),
                      trailing: Switch(
                        value: _bloc.optionValue == null
                            ? false
                            : _bloc.optionValue,
                        onChanged: (value) {
                          setState(() {
                            _bloc.optionValue = value;
                            BlocProvider.of<ChangeThemeBloc>(context)
                                .add(ChooseThemeEvent());
                          });
                        },
                        activeTrackColor: Colors.red,
                        activeColor: Colors.grey,
                      ),
                      leading: Icon(Icons.settings),
                    ),
                  ),
                  Visibility(
                    visible: _bloc.isLogin,
                    child: FlatButton(
                      child: Text('Đăng Xuất'),
                      onPressed: () {
                        BlocProvider.of<ProfileSettingBloc>(context)
                            .add(LogOut());
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      },
                    ),
                  )
                ],
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
