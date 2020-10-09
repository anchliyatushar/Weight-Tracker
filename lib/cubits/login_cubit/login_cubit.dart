import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:stack_finance_assignment/repositories/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitial());

  Future<void> loginUser(String sellerId, String password) async {
    emit(const LoginProcessing());

    String email = "$sellerId";
    if (sellerId != null &&
        password != null &&
        sellerId.isNotEmpty &&
        password.isNotEmpty) {
      _loginRepository
          .signInWithCredentials(email, password)
          .then((authResult) {
        Firestore firestore = Firestore.instance;

        firestore.collection("Users").document(sellerId).get().then((value) {
          emit(const LoginCompleted());
        }).catchError((err) =>
            emit(const LoginError("No Seller available with this Seller ID")));
      }).catchError((err) {
        print(err);
        emit(const LoginError("Invalid Credential Please try again"));
      });
    } else {
      if (sellerId == null || sellerId.isEmpty) {
        emit(const LoginError("Seller Id cannot be empty"));
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
