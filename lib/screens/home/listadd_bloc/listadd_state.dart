import 'package:meta/meta.dart';


@immutable
class AddState {
  final bool isNameValid;
  final bool isColorValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isColorValid;

  AddState({
    @required this.isNameValid,
    @required this.isColorValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory AddState.empty() {
    return AddState(
      isNameValid: false,
      isColorValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddState.loading() {
    return AddState(
      isNameValid: true,
      isColorValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddState.failure() {
    return AddState(
      isNameValid: true,
      isColorValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory AddState.success() {
    return AddState(
      isNameValid: true,
      isColorValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  AddState update({
    bool isNameValid,
    bool isColorValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isColorValid: isColorValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddState copyWith({
    bool isNameValid,
    bool isColorValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return AddState(
      isNameValid: isNameValid ?? this.isNameValid,
      isColorValid: isColorValid ?? this.isColorValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''AddState {
      isNameValid: $isNameValid,
      isColorValid: $isColorValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
