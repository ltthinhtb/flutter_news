import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Utils/apptheme.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_bloc.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_event.dart';
import 'package:flutter_news/page/sign_up_page/sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // ignore: close_sinks
  SignUpBloc _bloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _bloc = SignUpBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Đăng ký thành công'),
                duration: Duration(seconds: 3),
              ));
            }
            setState(() {

            });
            if (state is SignUpFail) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Đăng ký thất bại'),
                duration: Duration(seconds: 3),
              ));
            }
          },
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Đăng Ký'),
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: TextFormField(
                              controller: _nameController,
                              autovalidate: true,
                              autocorrect: false,
                              maxLines: 1,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: 'Tên',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: TextFormField(
                              controller: _surnameController,
                              autovalidate: true,
                              autocorrect: false,
                              maxLines: 1,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: 'Họ',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: TextFormField(
                              controller: _emailController,
                              autovalidate: true,
                              autocorrect: false,
                              maxLines: 1,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          color: AppTheme.red_dark,
                          onPressed: () {
                            BlocProvider.of<SignUpBloc>(context).add(SignUpEmailPassWord(_nameController.text,_surnameController.text,_emailController.text, _passwordController.text));
                          },
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
