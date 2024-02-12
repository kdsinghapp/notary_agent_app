class Validators {
  static String? required(String? value) {
    if (value?.isEmpty != false) {
      return 'Required!';
    } else {
      return null;
    }
  }

  static String? Function(String?) combineValidators(List<String? Function(String?)> validators) {
    return (String? val) {
      return validators.fold<String?>(null, (previousValue, element) => previousValue ?? element(val));
    };
  }
}
