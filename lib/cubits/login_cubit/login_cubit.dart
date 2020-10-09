import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';

import 'package:stack_finance_assignment/repositories/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  final UserCubit userCubit;

  LoginCubit(this._loginRepository, this.userCubit) : super(LoginInitial());

  Future<void> loginUser(String emailId, String password) async {
    emit(const LoginProcessing());

    String email = "$emailId";

    if (emailId != null &&
        password != null &&
        emailId.isNotEmpty &&
        password.isNotEmpty) {
      _loginRepository
          .signInWithCredentials(email, password)
          .then((authResult) {
        Firestore firestore = Firestore.instance;

        firestore.collection("Users").document(emailId).get().then((value) {
          emit(const LoginCompleted());
          userCubit.emitUserLoggedIn(authResult.user.uid);
        }).catchError((err) =>
            emit(const LoginError("No User available with this User ID")));
      }).catchError((err) {
        print(err);
        emit(const LoginError("Invalid Credential Please try again"));
      });
    } else {
      if (emailId == null || emailId.isEmpty) {
        emit(const LoginError("Email Id cannot be empty"));
      } else {
        emit(const LoginError("Password cannot be empty"));
      }
    }
  }

  emitLoginInitial() {
    emit(const LoginInitial());
  }

  Future<void> signOut() async {
    emit(const LoginSignProcessing());
    await _loginRepository.signOut();

    emit(const LoginSignOut());
  }
}
