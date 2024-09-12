import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(ChangeState(address: 'null'));


  Future<void> updateResult(String newAddress) async {
     emit(ChangeState(address: newAddress));
  }
}
