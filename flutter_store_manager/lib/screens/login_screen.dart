import 'package:flutter/material.dart';
import 'package:flutter_store_manager/blocs/login_bloc.dart';
import 'package:flutter_store_manager/screens/home_screen.dart';
import 'package:flutter_store_manager/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginBloc = LoginBloc();

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
     super.initState();
     _loginBloc.outState.listen((state) {
        switch(state) {
          case LoginState.SUCCESS:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())
            );
            break;
          case LoginState.FAIL:
            showDialog(context: context, builder: (context) => AlertDialog(
              title: Text("Erro"),
              content: Text("Credenciais inválidas ou sem privilégios.")
            ));
            break;
          case LoginState.LOADING:
          case LoginState.IDLE:
        }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          print(snapshot.data);
          switch(snapshot.data) {
            case LoginState.LOADING:
              return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                  )
              );
            case LoginState.IDLE:
            case LoginState.FAIL:
            case LoginState.SUCCESS:
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(
                                Icons.store,
                                color: Colors.deepOrangeAccent,
                                size: 160
                            ),
                            InputField(
                              icon: Icons.person,
                              hint: "Usuário",
                              obscure: false,
                              stream: _loginBloc.outEmail,
                              onChanged: _loginBloc.changeEmail,
                            ),
                            InputField(
                              icon: Icons.lock,
                              hint: "Senha",
                              obscure: true,
                              stream: _loginBloc.outPassword,
                              onChanged: _loginBloc.changePassword,
                            ),

                            SizedBox(
                              height:
                              32,
                            ),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 50,
                                    child: RaisedButton(
                                      color: Colors.orange,
                                      child: Text("Login"),
                                      onPressed: snapshot.hasData
                                          ? _loginBloc.submit
                                          : null,
                                      textColor: Colors.grey[850],
                                      disabledColor: Colors.deepOrange
                                          .withAlpha(100),
                                    ),
                                  );
                                }
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              );
          }
        }
      )
    );
  }
}
