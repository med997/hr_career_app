import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());


  Future<void> updateResult(String newAddress) async {
     emit(await ChangeState(address: newAddress));
  }
}
