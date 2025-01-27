class ServiceUrl {
  // static const baseUrl = "https://6wx31c44-8002.inc1.devtunnels.ms";
  static const baseUrl = "http://213.210.21.175:5001"; //live

// -----Auth url----------------
  static const loginUrl = "$baseUrl/AW0001/api/v1/signin";
  static const logoutUrl = "$baseUrl/auth/v1/logout";
  static const singupUrl = "$baseUrl/AW0001/api/v1/signup";
  static const refresTokenUrl = "$baseUrl/auth/create-access";
  static const refreshTokenUrl = "$baseUrl/auth/regenerate-token";
  static const postSignupCertificateUrl = "$baseUrl/certificate/v1/createUserCertificate";
  static const forgetPasswordUrl = "$baseUrl/api/users/forgot-password";
  static const confirmPasswordReset = "$baseUrl/auth/v1/resetPasswordCleaner";
  static const otpVerifyUrl = "$baseUrl/auth/v1/verify-otp";

  static const getAllServicesUrl = "$baseUrl/area/v1/getAllSeriveArea";
  static const getUserDetailsUrl = "$baseUrl/user/v1/getUserDetails";

  //dashboard urls
  static const getHomeProducts = "$baseUrl/AW0001/api/v1/getHomeProducts";
  static const getProductCategories = "$baseUrl/AW0001/api/v1/getallcategory";
  static const getAllCartItems = "$baseUrl/AW0001/api/v1/getitemcart";
  static const getDashboardData = "$baseUrl/booking/v1/cleanerInfo";

  //Job Booking urls
  static const acceptBookingUrl = "$baseUrl/booking/v1/acceptedBooking";
  static const uploadChecklistImagesUrl = "$baseUrl/bookingImage/v1/createBookingImage";
  static const paymentIntentUrl = "$baseUrl//payment/create-payment-intent";

  //profile
  static const getLicenseImages = "$baseUrl/certificate/v1/getUserCertificate";
  static const updateProfileUrl = "$baseUrl/user/v1/updateUserProfile";
}
