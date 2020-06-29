import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Utils/apptheme.dart';
import 'package:flutter_news/page/authentication_page/authenticatin_bloc.dart';
import 'package:flutter_news/page/authentication_page/authentication.dart';
import 'package:flutter_news/page/main_page/main_page.dart';
import 'package:flutter_news/page/profile_page/profile.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // ignore: close_sinks
  ProfileSettingBloc profileSettingBloc;
  AuthenticationBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    flutterWebViewPlugin.hide();
    profileSettingBloc = ProfileSettingBloc();
    _bloc = AuthenticationBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            currentPage: 3,
                          )));
            }
            if (state is AuthenticationFail) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Đăng nhập thất bại'),
                duration: Duration(seconds: 3),
              ));
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationLoading)
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              return WillPopScope(
                onWillPop: () => popToRefresh(context),
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Đăng Nhập'),
                  ),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SignInButton(
                            Buttons.Facebook,
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(LoginFacebook());
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                          ),
                          SignInButton(
                            Buttons.Google,
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(LoginInGoogle());
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Divider(
                                color: Colors.black,
                              )),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Hoặc")),
                              Expanded(
                                  child: Divider(
                                color: Colors.black,
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: TextFormField(
                                controller: _emailController,
                                autovalidate: true,
                                autocorrect: false,
                                maxLines: 1,
                                autofocus: false,
                                onChanged: (text) =>
                                    _bloc.add(ValidateEmail(text)),
                                decoration: InputDecoration(
                                    errorText: _bloc.errorEmail,
                                    hintText: 'Email',
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20))),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, bottom: 10),
                            child: Center(
                              child: TextFormField(
                                controller: _passwordController,
                                maxLines: 1,
                                autofocus: false,
                                obscureText: true,
                                autovalidate: true,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            color: AppTheme.red_dark,
                            onPressed: () {
                              _bloc.add(LoginInEmailPassWord(
                                  _emailController.text,
                                  _passwordController.text));
                            },
                            child: Text(
                              'Đăng Nhập',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            child: Text(
                              'Quên mật khẩu',
                              style: TextStyle(
                                  color: AppTheme.red_dark,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            child: Text('Chưa có tài khoản? Đăng ký'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  // ignore: missing_return
  Future<Null> popToRefresh(BuildContext context) {
    FlutterWebviewPlugin().show();
    Navigator.of(context).pop();
  }
}
