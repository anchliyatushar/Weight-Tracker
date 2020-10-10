import 'package:bloc/bloc.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';
import 'package:stack_finance_assignment/repositories/weight_repository.dart';

class EditWeightCubit extends Cubit<WeightModel> {
  final WeightRepository weightRepository;
  final WeightModel weightModel;
  UserCubit userCubit;

  EditWeightCubit(this.weightRepository, this.weightModel) : super(weightModel);

  emitNewHeight(WeightModel weightModel, double height) {
    emit(weightModel.copyWith(
        height: double.parse(height.toStringAsExponential(1))));
  }

  emitNewWeight(WeightModel weightModel, double weight) {
    emit(weightModel.copyWith(
        weight: double.parse(weight.toStringAsExponential(1))));
  }

  emitNewTimeStamp(WeightModel weightModel, DateTime dateTime) {
    emit(weightModel.copyWith(selectedDate: dateTime));
  }

  sendDataToDb(WeightModel weightModel, String uid) {
    weightRepository.addWeightToDb(uid, weightModel).then((value) {
      emit(weightModel.copyWith(id: "", status: WeightStatus.Success));
      emit(weightModel.copyWith(id: "", status: WeightStatus.Initial));
    }).catchError((err) {
      print(err);
      emit(weightModel.copyWith(status: WeightStatus.Error));
      emit(weightModel.copyWith(status: WeightStatus.Initial));
    });
  }
}
