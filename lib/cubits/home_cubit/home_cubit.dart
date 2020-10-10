import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';
import 'package:stack_finance_assignment/repositories/weight_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final WeightRepository weightRepository;


  HomeCubit(this.weightRepository) : super(HomeInitial());
  getUserWeightsStream(String uid) {
    return weightRepository.getUserWeightsStream(uid);
  }

  deleteUserWeights(WeightModel weightModel, String uid) {
    weightRepository.deleteWeightFromDb(uid, weightModel);
  }
}
