import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stack_finance_assignment/cubits/login_cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _sellerId, _password;
  bool _isPasswordObscure;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _sellerIdNode, _passwordNode;

  @override
  void initState() {
    super.initState();
    _isPasswordObscure = true;
    _sellerIdNode = FocusNode();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _sellerIdNode?.dispose();
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
                    "Seller Login",
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
                              initialValue: _sellerId,
                              decoration: InputDecoration(
                                labelText: "Seller's Id",
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 10, 0, 6),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (val) =>
                                  _passwordNode.requestFocus(),
                              focusNode: _sellerIdNode,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (val.trim().isEmpty) {
                                  return "Please Enter a valid Seller's Id";
                                }
                                return null;
                              },
                              onChanged: (sellerId) {
                                _sellerId = sellerId;
                                print(_sellerId);
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
                                _loginUser(context, _sellerId, _password);
                              },
                              onChanged: (password) {
                                _password = password;
                                print("password" + _password);
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            _emitLoginInitial();
                          },
                          child: Text("Login →",
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ),
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

  void _loginUser(BuildContext context, String sellerId, String password) {
    final loginCubit = context.bloc<LoginCubit>();
    loginCubit.loginUser(sellerId, password);
  }

  void _emitLoginInitial() {
    final loginCubit = context.bloc<LoginCubit>();
    loginCubit.emitLoginInitial();
  }
}
