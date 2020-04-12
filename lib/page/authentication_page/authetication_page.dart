import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Utils/apptheme.dart';
import 'package:flutter_news/page/authentication_page/authenticatin_bloc.dart';
import 'package:flutter_news/page/authentication_page/authentication.dart';
import 'package:flutter_news/page/home_page/home_page.dart';
import 'package:flutter_news/service/database.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DataBase _base = DataBase();
  // ignore: close_sinks
  AuthenticationBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyHomePage()));
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
              return Scaffold(
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
                            _base.dataUser();
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
                              decoration: InputDecoration(
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
                            _bloc.add(LoginInEmailPassWord(_emailController.text, _passwordController.text));
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
                          child: Text('Chưa có tài khoản? Đăng ký'),
                        ),
                      ],
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
}
