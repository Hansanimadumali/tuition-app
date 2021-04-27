import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/repository/user_repository.dart';
import 'package:tution_app/state_mangement/login/login_sm.dart';
import 'package:tution_app/state_mangement/users/authentication_sm.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();

  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state){
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState(){
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose(){
    _loginBloc.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state){
        if(state.isFailure){
          Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text("Login Failure"),Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                )
              );
        }
        if(state.isSubmitting){
          Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Logged In..."),
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              );
        }
        if(state.isSuccess){
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }

      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context,LoginState state){
          return Container(
            child: Form(
              child: Column(
                children: <Widget>[
                  _showEmailInput(state),
                  _showPasswordInput(state),
                  _showPrimaryButton(state),
                  _showGithubButton(state, context)
                ],
              ),
            ),
          );
        },
      ),
    );
  }



  Widget _showEmailInput(LoginState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        controller: _emailController,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email', icon: new Icon(Icons.mail, color: Colors.grey)),
        validator: (value) => !state.isEmailValid?'Invalid Email': null,
        autovalidate: true,
        autocorrect: false,

      ),
    );
  }

  Widget _showPasswordInput(LoginState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        controller: _passwordController,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => !state.isPasswordValid ? 'Invalid Password' : null,
        autocorrect: false,
        autovalidate: true,
      ),
    );
  }

  Widget _showPrimaryButton(LoginState state) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 0.0),
      child: new InkWell(
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              color: isLoginButtonEnabled(state)?Color(0xff385170):Colors.grey,
              borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: new Text(
              'Login',
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
        onTap:(){
          if(isLoginButtonEnabled(state)){
            _onFormSubmitted();
          }
        },
      ),
    );
  }

  Widget _showGithubButton(LoginState state, BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(45.0, 5.0, 45.0, 0.0),
      child: new InkWell(
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              color: Color(0xff385170),
              borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: new Text(
              'Github Login',
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
        onTap:(){
            _onGithubButtonPressed(context);
        },
      ),
    );
  }
  void _onEmailChanged() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.dispatch(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onGithubButtonPressed(BuildContext context){
    _loginBloc.dispatch(
      LoginWithGithubPressed(context: context)
    );
  }
}
