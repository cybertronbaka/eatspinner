class Routes{
  static const root = '/';
  static const spinner = '/app/spinner';
  static const places = '/app/places';
  static const addPlace = '/app/places/add';
  static String editPlace([int? id]) => '/app/places/edit/${id ?? ':id'}';
  static const signup = '/auth/signup';
  static const login = '/auth/login';
  static const forgotPassword = '/auth/forgotPassword';
}