class ApiConstants {
  static const String baseUrl = "https://dirassaty.rechidiahmed.me/api/v1/";
  static const login = "auth/login";
  static const sendOtp = "auth/forgot-password";
  static const verifyOtp = "auth/verify-otp";
  static const resetPassword = "reset-password";
  static const getMyStudents = "parents/my-students";
  static const getStudentAbsence = "absences/student";
  static const sendJustification = "justifications";
  static const getMe = "parents/me";
  static const updateParent = "parents";
  static const changePassword = "auth/change-password";
  static const updateJustification = "justifications";
  static const getStudentYears = "grades/years-trimestres/student";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "no Internet Connection";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
