import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_recording/bloc/weight_event.dart';
import 'package:weight_recording/bloc/weight_state.dart';
import '../repo/weight_repo.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  final WeightRepository weightRepository;
  WeightBloc({required this.weightRepository}) : super(InitialState()) {
    on<Create>((event, emit) async {
      emit(WeightAdding());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await weightRepository.create(name: event.name, weight: event.weight);
        emit(WeightAdded());
      } catch (e) {
        emit(WeightError(e.toString()));
      }
    });

    on<GetData>((event, emit) async {
      emit(WeightLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
       final data =await weightRepository.get();
        emit(WeightLoaded(data!));
      } catch (e) {
        emit(WeightError(e.toString()));
      }
    });

    on<DeleteData>((event, emit)async {

      try{
        emit(WeightDeleting());
        await weightRepository.delete();
        emit(WeightDeleted());
      }catch(e){
        emit(WeightError(e.toString()));
      }

    });


  }
}
