import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stack_finance_assignment/repositories/weight_repository.dart';

part 'add_weight_state.dart';

class AddWeightCubit extends Cubit<AddWeightState> {
  final WeightRepository weightRepository;

  AddWeightCubit(this.weightRepository) : super(AddWeightInitial());
}
