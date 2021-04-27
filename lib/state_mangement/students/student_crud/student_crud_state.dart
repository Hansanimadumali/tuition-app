import 'package:meta/meta.dart';

@immutable
class StudentAddState {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isGradeValid;
  final bool isTelephoneValid;
  final bool isParentTypeValid;
  final bool isParentMobileValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isFirstNameValid &&
      isLastNameValid &&
      isGradeValid &&
      isParentTypeValid &&
      isParentMobileValid &&
      isTelephoneValid;

  StudentAddState(
      {@required this.isFirstNameValid,
      @required this.isLastNameValid,
      @required this.isGradeValid,
      @required this.isTelephoneValid,
      @required this.isParentTypeValid,
      @required this.isParentMobileValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure});

  factory StudentAddState.empty() {
    return StudentAddState(
        isFirstNameValid: true,
        isLastNameValid: true,
        isGradeValid: true,
        isTelephoneValid: true,
        isParentMobileValid: true,
        isParentTypeValid: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false);
  }

  factory StudentAddState.loading() {
    return StudentAddState(
        isFirstNameValid: true,
        isLastNameValid: true,
        isGradeValid: true,
        isTelephoneValid: true,
        isParentMobileValid: true,
        isParentTypeValid: true,
        isSubmitting: true,
        isFailure: false,
        isSuccess: false);
  }

  factory StudentAddState.failure() {
    return StudentAddState(
        isFirstNameValid: true,
        isLastNameValid: true,
        isGradeValid: true,
        isTelephoneValid: true,
        isParentMobileValid: true,
        isParentTypeValid: true,
        isSubmitting: false,
        isFailure: true,
        isSuccess: false);
  }

  factory StudentAddState.success() {
    return StudentAddState(
        isFirstNameValid: true,
        isLastNameValid: true,
        isGradeValid: true,
        isTelephoneValid: true,
        isParentMobileValid: true,
        isParentTypeValid: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: true);
  }

  StudentAddState update({
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isGradeValid,
    bool isTelephoneValid,
    bool isParentMobileValid,
    bool isParentTypeValid,
  }) {
    return copyWith(
        isFirstNameValid: isFirstNameValid,
        isLastNameValid: isLastNameValid,
        isGradeValid: isGradeValid,
        isTelephoneValid: isTelephoneValid,
        isParentMobileValid: isParentMobileValid,
        isParentTypeValid: isParentTypeValid,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false);
  }

  StudentAddState copyWith(
      {bool isFirstNameValid,
      bool isLastNameValid,
      bool isGradeValid,
      bool isTelephoneValid,
      bool isParentMobileValid,
      bool isParentTypeValid,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure}) {
    return StudentAddState(
        isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
        isLastNameValid: isLastNameValid ?? this.isLastNameValid,
        isGradeValid: isGradeValid ?? this.isGradeValid,
        isTelephoneValid: isTelephoneValid ?? this.isTelephoneValid,
        isParentTypeValid: isParentTypeValid ?? this.isParentTypeValid,
        isParentMobileValid: isParentMobileValid ?? this.isParentMobileValid,
        isSuccess: isSuccess ?? this.isSuccess,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return '''StudentAddState {
        isFirstNameValid:$isFirstNameValid,
      isLastNameValid:$isLastNameValid,
      isGradeValid:$isGradeValid,
      isTelephoneValid:$isTelephoneValid,
      isParentMobileValid:$isParentMobileValid,
      isParentTypeValid:$isParentTypeValid,
    }
    ''';
  }
}
