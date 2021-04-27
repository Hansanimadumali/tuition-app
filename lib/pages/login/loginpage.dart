import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/pages/login/login_page_widgets/login_form.dart';
import 'package:tution_app/repository/user_repository.dart';
import 'package:tution_app/state_mangement/login/login_sm.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  final UserRepository _userRepository;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(userRepository: _userRepository);
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:BlocProvider<LoginBloc>(
      bloc: _loginBloc,
      child: new Container(
        padding: EdgeInsets.all(16.0),
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showLogo(), 
            LoginForm(userRepository: _userRepository,)
            ],
        ),
      ),
    ));
  }

  Widget _showLogo() {
    return new Hero(
        tag: 'hero',
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 48.0,
              child: Image.asset('assets/flutter-icon.png')),
        ));
  }

}
