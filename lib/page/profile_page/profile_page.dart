import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/page/authentication_page/authetication_page.dart';
import 'package:flutter_news/page/home_page/home_page.dart';
import 'package:flutter_news/page/profile_page/profile.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_page.dart';
import 'package:flutter_news/service/AuthService.dart';
import 'package:flutter_news/theme_bloc/chang_theme.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileSettingBloc _bloc;
  bool isSwitch = false;
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
      child: BlocListener<ProfileSettingBloc, ProfileSettingState>(
        listener:(context,state){
          if (state is LogOutSuccess){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
          }
        } ,
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
                          CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              size: 60,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _bloc.isLogin
                              ? Text(_bloc.userName)
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
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
                      title: Text('Tin đã xem'),
                      trailing: Icon(Icons.chevron_right),
                      leading: Icon(Icons.refresh),
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
                          BlocProvider.of<ProfileSettingBloc>(context).add(LogOut());
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
