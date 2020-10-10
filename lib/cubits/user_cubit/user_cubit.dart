import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stack_finance_assignment/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit()
      : super(UserNotLoggedIn(UserModel(isUserLoggedIn: false, uid: "")));

  emitUserNotLoggedIn() {
    emit(const UserNotLoggedIn(UserModel(isUserLoggedIn: false, uid: "")));
  }

  emitUserLoggedIn(String uid) {
    emit(UserLoggedIn(UserModel(isUserLoggedIn: true, uid: uid)));
  }

  @override
  UserState fromJson(Map<String, dynamic> json) {
    try {
      final user = UserModel.fromJson(json);
      if (user.isUserLoggedIn) {
        return UserLoggedIn(user);
      }
      return UserNotLoggedIn(user);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    if (state is UserLoggedIn) {
      return state.userModel.toJson();
    }
    return null;
  }
}
