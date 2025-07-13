class AppValidationMessages {
  static const String requiredField = 'This field is required';
  static const String requiredEmail = 'Email is required';
  static const String requiredPassword = 'Password is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String passwordTooShort =
      'Password must be at least 6 characters long';
  static const String reEnterPassword = 'Re-enter your password';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String dobRequired = 'Date of birth is required';
  static const String invalidName = 'Please enter a valid name';
  static const String invalidGender = 'Please select gender';
  static const String regFailed = 'Registration failed, please try again';
  static const String regSuccess = 'Registration successful, please login';
  static const String errorPickImage = 'Error picking image';

  //error messages
  static const String userNotFound = "User not found";
  static const String postsNotFound = "No posts available";
  static const String logoutFailed = "Logout failed";
  static const String loginFailed = "Invalid credentials";
  static const String emailExisted = "User with this email already exists";

  //success messages
  static const String loginSuccess = 'Login successful!';
  static const String postPublished = 'Post published successfully!';
  static const String registrationSuccess = 'Registration successful!';
  static const String updateProfileSuccess = 'Profile updated successfully!';

  //regular expressions
  static const String emailRegx = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
  static const String nameRegx = r"^[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*$";
  static const String passwordRegx =
      r'^(?=.*[A-Z])(?=.*[\W_])(?=.*[a-zA-Z0-9]).{6,}$';
  static const String strongPassRegExp =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'; // At least 6 characters, one uppercase, one lowercase, one digit, one special character
}
