import 'package:flutter_bloc/flutter_bloc.dart';

class AppOpenCubit extends Cubit<bool> {
  AppOpenCubit() : super(false);

  void reset() {
    emit(false);
  }

  void updateAppOpen({required bool value}) {
    emit(value);
  }
}
