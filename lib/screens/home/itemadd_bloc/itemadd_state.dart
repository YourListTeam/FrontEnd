import 'package:meta/meta.dart';


@immutable
class ItemAddState {
  final bool isNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMsg;

  bool get isFormValid => isNameValid;

  ItemAddState({
    @required this.isNameValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    this.errorMsg
  });

  factory ItemAddState.empty() {
    return ItemAddState(
      isNameValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ItemAddState.loading() {
    return ItemAddState(
      isNameValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ItemAddState.failure() {
    return ItemAddState(
      isNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMsg: "Your Request Failed"
    );
  }

  factory ItemAddState.badPerms() {
    return ItemAddState(
        isNameValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        errorMsg: "You don't have correct permissions"
    );
  }

  factory ItemAddState.success() {
    return ItemAddState(
      isNameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  ItemAddState update({
    bool isNameValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  ItemAddState copyWith({
    bool isNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return ItemAddState(
      isNameValid: isNameValid ?? this.isNameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''ItemAddState {
      isNameValid: $isNameValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
