import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expense_tracker/core/login_states.dart';
import 'package:expense_tracker/repository/login_repository.dart';
import 'package:expense_tracker/model/user.dart';

class LoginBloc extends Cubit<LogInState> {
  LoginRepository loginRepository = LoginRepository();

  LoginBloc() : super(InitState());

  validateInputs(String email, String password) async {
    RegExp emailPattern = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$");
    RegExp passwordPattern =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!emailPattern.hasMatch(email)) {
      emit(InvalidEmail());
    }
    if (!passwordPattern.hasMatch(password)) {
      emit(InvalidPassword());
    }
    if (emailPattern.hasMatch(email) && passwordPattern.hasMatch(password)) {
      if (await loginRepository.login(User(email, password)) ?? false) {
        emit(LoggedInSuccessfully());
      } else {
        emit(IncorrectCredentials());
      }
    }
  }

  // validateCredentials(String email, String password) {
  //   if (users.containsKey(email)) {
  //     if (users[email] == password) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  void fieldChanged(String text) {
    emit(FieldChange());
  }
}
