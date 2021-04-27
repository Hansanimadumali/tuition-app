import 'package:meta/meta.dart';

@immutable
class ClassAddState {
  final bool isClassNameValid;
  final bool isGradeValid;
  final bool isInstituteValid;
  final bool isTeacherValid;
  final bool isSubjectValid;
  final bool isClassFeeValid;
  final bool isEndingDateValid;
  final bool isInstituteFeeValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isClassNameValid && isClassFeeValid && isInstituteFeeValid;

  ClassAddState(
      {@required this.isClassNameValid,
      @required this.isGradeValid,
      @required this.isInstituteValid,
      @required this.isTeacherValid,
      @required this.isSubjectValid,
      @required this.isClassFeeValid,
      @required this.isEndingDateValid,
      @required this.isInstituteFeeValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure});

  factory ClassAddState.empty() {
    return ClassAddState(
        isClassFeeValid: true,
        isGradeValid: true,
        isInstituteValid: true,
        isTeacherValid: true,
        isSubjectValid: true,
        isClassNameValid: true,
        isEndingDateValid: true,
        isInstituteFeeValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  factory ClassAddState.loading() {
    return ClassAddState(
        isClassFeeValid: true,
        isGradeValid: true,
        isInstituteValid: true,
        isTeacherValid: true,
        isSubjectValid: true,
        isClassNameValid: true,
        isEndingDateValid: true,
        isInstituteFeeValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory ClassAddState.failure() {
    return ClassAddState(
        isClassFeeValid: true,
        isGradeValid: true,
        isInstituteValid: true,
        isTeacherValid: true,
        isSubjectValid: true,
        isClassNameValid: true,
        isEndingDateValid: true,
        isInstituteFeeValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }

  factory ClassAddState.success() {
    return ClassAddState(
        isClassFeeValid: true,
        isGradeValid: true,
        isInstituteValid: true,
        isTeacherValid: true,
        isSubjectValid: true,
        isClassNameValid: true,
        isEndingDateValid: true,
        isInstituteFeeValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }

  ClassAddState update(
      {bool isClassNameValid,
      bool isGradeValid,
      bool isInstituteValid,
      bool isTeacherValid,
      bool isSubjectValid,
      bool isClassFeeValid,
      bool isInstituteFeeValid,
      bool isEndingDateValid}) {
    return copyWith(
        isClassNameValid: isClassNameValid,
        isGradeValid: isGradeValid,
        isInstituteValid: isInstituteValid,
        isTeacherValid: isTeacherValid,
        isSubjectValid: isSubjectValid,
        isClassFeeValid: isClassFeeValid,
        isInstituteFeeValid: isInstituteFeeValid,
        isEndingDateValid: isEndingDateValid,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false);
  }

  ClassAddState copyWith(
      {bool isClassNameValid,
      bool isGradeValid,
      bool isInstituteValid,
      bool isTeacherValid,
      bool isSubjectValid,
      bool isClassFeeValid,
      bool isInstituteFeeValid,
      bool isEndingDateValid,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure}) {
    return ClassAddState(
        isClassFeeValid: isClassFeeValid ?? this.isClassFeeValid,
        isGradeValid: isGradeValid ?? this.isGradeValid,
        isInstituteValid: isInstituteValid ?? this.isInstituteValid,
        isTeacherValid: isTeacherValid ?? this.isTeacherValid,
        isSubjectValid: isSubjectValid ?? this.isSubjectValid,
        isClassNameValid: isClassNameValid ?? this.isClassNameValid,
        isEndingDateValid: isEndingDateValid ?? this.isEndingDateValid,
        isInstituteFeeValid: isInstituteFeeValid ?? this.isInstituteFeeValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return ''' ClassAddState {
      isClassNameValid:$isClassNameValid,
      isGradeValid:$isGradeValid,
      isClassFeeValid:$isClassFeeValid,
      isInstituteFeeValid: $isInstituteFeeValid,
      isSubjectValid: $isSubjectValid
    }''';
  }
}
