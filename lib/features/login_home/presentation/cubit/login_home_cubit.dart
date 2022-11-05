import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/core/error/error_model.dart';
import 'package:simba_courier/features/login_home/domain/entities/login_entity.dart';

import '../../../../core/services/locator.dart';
import '../../domain/usecases/login_usecase.dart';

part 'login_home_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginHomeInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  bool isPassword = true;
  void changeIcon() {
    emit(LoginHomeInitial());
    isPassword = !isPassword;
    emit(ChangeIcon());
  }

  login(String name, password) async {
    emit(Loading());
    final result = await LoginUsecase(sl()).login(name, password);

    result.fold((l) => emit(LoginError(ErrorModel.fromJson(l.response!.data))),
        (r) => emit(LoginSuccess(r)));
  }
}
