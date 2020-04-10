import 'package:meta/meta.dart';


@immutable
class AddState {
  final bool isNameValid;
  final bool isColorValid;
  final bool isAddressValid;
  final bool isLocNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isColorValid && isLocNameValid && isAddressValid;

  AddState({
    @required this.isNameValid,
    @required this.isColorValid,
    @required this.isAddressValid,
    @required this.isLocNameValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory AddState.empty() {
    return AddState(
      isNameValid: false,
      isColorValid: false,
      isAddressValid: false,
      isLocNameValid: false,
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
      isAddressValid: true,
      isLocNameValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddState.failure() {
    return AddState(
      isNameValid: true,
      isColorValid: true,
      isAddressValid: true,
      isLocNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory AddState.success() {
    return AddState(
      isNameValid: true,
      isColorValid: true,
      isAddressValid: true,
      isLocNameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  AddState update({
    bool isNameValid,
    bool isColorValid,
    bool isAddressValid,
    bool isLocNameValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isColorValid: isColorValid,
      isAddressValid: isAddressValid,
      isLocNameValid: isLocNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddState copyWith({
    bool isNameValid,
    bool isColorValid,
    bool isAddressValid,
    bool isLocNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return AddState(
      isNameValid: isNameValid ?? this.isNameValid,
      isColorValid: isColorValid ?? this.isColorValid,
      isLocNameValid: isLocNameValid ?? this.isLocNameValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
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
      isAddressValid: $isAddressValid,
      isLocNameValid: $isLocNameValid
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
