import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stack_finance_assignment/cubits/login_cubit/login_cubit.dart';
import 'package:stack_finance_assignment/utils/util_functions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _emailId, _password;
  bool _isPasswordObscure;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode emailIdNode, _passwordNode;

  @override
  void initState() {
    super.initState();
    _isPasswordObscure = true;
    emailIdNode = FocusNode();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    emailIdNode?.dispose();
    _passwordNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state is LoginError) {
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );

              _formKey.currentState.validate();
            }

            if (state is LoginCompleted) {
              Fluttertoast.showToast(
                msg: "Welcome 😃",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            }
          },
          builder: (context, state) {
            return _buildLoginPage(context, state);
          },
        ),
      ),
    );
  }

  _buildLoginPage(BuildContext context, LoginState state) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[100],
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "User Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              cursorHeight: 22,
                              style: TextStyle(fontSize: 18),
                              initialValue: _emailId,
                              decoration: InputDecoration(
                                labelText: "Email",
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 10, 0, 6),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (val) =>
                                  _passwordNode.requestFocus(),
                              focusNode: emailIdNode,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (!validateEmail(val)) {
                                  return "Please Enter a valid Email Id";
                                }
                                return null;
                              },
                              onChanged: (emailId) {
                                _emailId = emailId;
                                print(emailId);
                              },
                            ),
                            TextFormField(
                              cursorHeight: 22,
                              style: TextStyle(fontSize: 18),
                              initialValue: _password,
                              focusNode: _passwordNode,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10, 0, 6),
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: _isPasswordObscure
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordObscure =
                                            !_isPasswordObscure;
                                      });
                                    },
                                  )),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.go,
                              obscureText: _isPasswordObscure,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (val.trim().isEmpty) {
                                  return "Please Enter a valid Password";
                                }
                                return null;
                              },
                              onFieldSubmitted: (val) {
                                _loginUser(context, _emailId, _password);
                              },
                              onChanged: (password) {
                                _password = password;
                                print("password" + _password);
                              },
                            ),
                          ],
                        ),
                      ),
                      if (state is LoginProcessing) ...{
                        CircularProgressIndicator()
                      } else ...{
                        _buildLoginButton()
                      }
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoginButton() {
    return InkWell(
      onTap: () => _loginUser(context, _emailId, _password),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.yellow[600], Colors.red]),
        ),
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Center(
            child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  void _loginUser(BuildContext context, String emailId, String password) {
    final loginCubit = context.bloc<LoginCubit>();
    loginCubit.loginUser(emailId, password);
  }
}
