class ApiEndpoint {
static String baseUrl = "http://13.51.255.89/api/";
static String baseUrlImage = "http://13.51.255.89/user/";
  static String loginUser = baseUrl+'login';
  static String registerUser = baseUrl+'register';
  static String selectUser = baseUrl+'select_user_type';
  static String forgotPwd = baseUrl+'verificationCode';
  static String checkOTP = baseUrl+'verifyCode';
  static String newPassword = baseUrl+'password';
  static String updatePassword = baseUrl+'changePassword';
  static String updateProfile = baseUrl+'update/user';
  static String addMembership = baseUrl+'storeMembership';
  static String addService = baseUrl+'store/service';
  static String checkSlots = baseUrl+'slot/check';
  static String userData= baseUrl+'userData';
  static String deleteUser= baseUrl+'deleteUser';
  static String allUser= baseUrl+'allUsers';
  static String freshFaces= baseUrl+'newUsers';

  static String propertyList = baseUrl+'listing-properties-type';
  static String basicList = baseUrl+'listing-basic-info';
  static String otherList = baseUrl+'listing-other-amenities';
  static String addProperty = baseUrl+'add-listing-properties-type';
  static String getAllProperties = baseUrl+'get-all-properties-data';
  static String getPropertyDetail = baseUrl+'get-detail-properties';
  static String userWishListProperty = baseUrl+'user-whishlist-property';
  static String getUserWishList = baseUrl+'get-user-whishlist-property';
  static String getUserListProperty = baseUrl+'get-user-listing-properties';
  static String getProfile = baseUrl+'get-personal-info';
  // static String updateProfile = baseUrl+'change-personal-info';
  static String userLike = baseUrl+'user_likes';
  static String addComment = baseUrl+'add_comment';
  // static String deleteUser = baseUrl+'delete_user';
  static String deleteComment = baseUrl+'delete_comment';
  static String deleteProperty = baseUrl+'delete_property';
  static String getAllComments = baseUrl+'get_all_comments';
  static String getUserProperty = baseUrl+'get_user_property';
  static String reportProperty = baseUrl+'report_user';
  static String blockUser = baseUrl+'block_user';
  static String blockList = baseUrl+'block_list';


}
