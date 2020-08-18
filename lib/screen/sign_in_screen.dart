import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/auth/auth_bloc.dart';
import 'package:kpop/bloc/login/login_bloc.dart';
import 'package:kpop/bloc/login/login_event.dart';
import 'package:kpop/bloc/login/login_state.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/localizations.dart';
import 'package:kpop/widget/input_text_box.dart';

class SiginInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationBloc: BlocProvider.of<AuthBloc>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: SafeArea(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.744,
              child: SignInForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  List<FocusNode> fnList = [
    FocusNode(),
    FocusNode(),
  ];
  List<TextEditingController> tecList = [
    TextEditingController(),
    TextEditingController()
  ];
  @override
  void dispose() {
    fnList.forEach((f) => f.dispose);
    tecList.forEach((f) => f.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          id: tecList[0].text,
          password: tecList[1].text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.white,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/icon/icon_login_normal.png",
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
              InputTextBox(
                hintText: getLocalizations.email,
                nextFocusNode: fnList[1],
                keyboardType: TextInputType.emailAddress,
                controller: tecList[0],
                boxColor: CustomColor.base,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              InputTextBox(
                hintText: getLocalizations.password,
                keyboardType: TextInputType.visiblePassword,
                controller: tecList[1],
                obscureText: true,
                focusNode: fnList[1],
                boxColor: CustomColor.base,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              GestureDetector(
                onTap: _onLoginButtonPressed,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.067,
                  decoration: BoxDecoration(
                    color: CustomColor.main,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    getLocalizations.login,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  getLocalizations.findPw,
                  style: TextStyle(color: CustomColor.main),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                height: MediaQuery.of(context).size.height * 0.067,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColor.main,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                  child: Text(
                    getLocalizations.signUp,
                    style: TextStyle(
                      color: CustomColor.main,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
