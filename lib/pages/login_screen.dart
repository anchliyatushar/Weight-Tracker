import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stack_finance_assignment/cubits/login_cubit/login_cubit.dart';
import 'package:stack_finance_assignment/utils/strings.dart';
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
        backgroundColor: my_primary_color,
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
            color: my_primary_light_color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: my_primary_light_color,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "User Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
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
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              initialValue: _emailId,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: "Email",
                                focusColor: Colors.white,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white70),
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
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              initialValue: _password,
                              focusNode: _passwordNode,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(color: Colors.white70),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10, 0, 6),
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: _isPasswordObscure
                                        ? Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Colors.white,
                                          ),
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
                      SizedBox(
                        height: 15,
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
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: my_accent_color,
        ),
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Center(
            child: Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  void _loginUser(BuildContext context, String emailId, String password) {
    final loginCubit = context.bloc<LoginCubit>();
    loginCubit.loginUser(emailId, password);
  }
}
