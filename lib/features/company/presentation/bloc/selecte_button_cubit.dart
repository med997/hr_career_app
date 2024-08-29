import 'package:bloc/bloc.dart';

part 'select_button_state.dart';

class SelectButtonCubit extends Cubit<SelectButtonState> {
  SelectButtonCubit() : super(SelectButtonState(selectIndex: 0));

  selectedIndex(int index) => emit(SelectButtonState(selectIndex: index));
}
