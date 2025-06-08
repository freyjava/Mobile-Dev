class Validators {

  static String? validateName(String? value){
    if(value == null || value.trim().isEmpty){
      return 'Name is required!';
    }
    if(value.trim().length < 2){
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  static String? validateEmail(String? value){
    if(value == null || value.trim().isEmpty){
      return 'Email is required!';
    }
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",caseSensitive: false);
    if(!emailRegex.hasMatch(value.trim())){
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value){
    if(value == null || value.trim().isEmpty){
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$");
    if(!phoneRegex.hasMatch(value.trim())){
      return 'Please enter a valid phone number.Eg(010 12467,+855 1234568)';
    }

    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), ' ');
    if(digitsOnly.length < 8 || digitsOnly.length > 12){
      return 'Phone number must be between 8 and 12 digits!';
    }

    return null;
  }

  static String? validateClassName(String? value){
    if(value == null || value.trim().isEmpty){
      return 'Class name is required!';
    }
    return null;
  }

  static String? validateDepartment(String? value){
    if(value == null || value.trim().isEmpty){
      return 'Department name is required!';
    }
    return null;
  }

  static String? validateGender(String? value){
    if(value == null || value.trim().isEmpty){
      return 'Gender is required!';
    }
    return null;
  }

  static String? validateField(String? value, String fieldName){
    if(value == null || value.trim().isEmpty){
      return '$fieldName is required';
    }
    return null;
  }
} 