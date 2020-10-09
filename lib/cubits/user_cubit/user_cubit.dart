import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserNotLoggedIn());

  emitUserNotLoggedIn() {
    emit(const UserNotLoggedIn());
  }

  emitUserLoggedIn(String sellerId) {
    emit(const UserLoggedIn());
  }
}
