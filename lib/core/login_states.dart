abstract class LogInState {}

class InitState extends LogInState {}

class SignInButtonPressed extends LogInState {}

class FieldChange extends LogInState {}

class InvalidEmail extends LogInState {}

class InvalidPassword extends LogInState {}

class LoggedInSuccessfully extends LogInState {}

class IncorrectCredentials extends LogInState {}
