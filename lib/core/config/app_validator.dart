class AppValidator {
  // email validation
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Password validation
  static final RegExp uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp numberRegex = RegExp(r'[0-9]');
  static final RegExp passwordStrongRegex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  );

  // Name validation (letters and spaces only, max 30 chars)
  static final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]{1,30}$');

  // NIK validation (16 digits for Indonesian NIK)
  static final RegExp nikRegex = RegExp(r'^[0-9]{16}$');

  // Phone number validation (Indonesian format)
  static final RegExp phoneRegex = RegExp(r'^(\+62|62|0)[0-9]{9,12}$');

  // Address validation (more flexible, just check length)
  static final RegExp addressRegex = RegExp(r'^.{1,200}$');

  // Validation methods
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'input tidak boleh kosong!';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'harap masukan email yang valid!';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'input tidak boleh kosong!';
    }
    // Check minimal 8 karakter
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    // Check huruf besar
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password harus mengandung minimal 1 huruf besar';
    }
    // Check huruf kecil
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password harus mengandung minimal 1 huruf kecil';
    }
    // Check angka
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password harus mengandung minimal 1 angka';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'input tidak boleh kosong!';
    }
    if (value.length > 30) {
      return 'Nama terlalu panjang (maksimal 30 karakter)';
    }
    if (!nameRegex.hasMatch(value)) {
      return 'Nama hanya boleh mengandung huruf dan spasi';
    }
    return null;
  }

  static String? validateNik(String? value) {
    if (value == null || value.isEmpty) {
      return 'input tidak boleh kosong!';
    }
    if (!nikRegex.hasMatch(value)) {
      return 'NIK must be 16 digits';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'input tidak boleh kosong!';
    }
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'input tidak boleh kosong!';
    }
    if (value.length > 200) {
      return 'Address too long (max 200 characters)';
    }
    return null;
  }

  // Password strength checker methods
  static bool hasUpperCase(String password) {
    return uppercaseRegex.hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return lowercaseRegex.hasMatch(password);
  }

  static bool hasNumber(String password) {
    return numberRegex.hasMatch(password);
  }

  static bool hasMinLength(String password, {int minLength = 8}) {
    return password.length >= minLength;
  }
}
