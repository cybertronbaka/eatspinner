class Routes{
  static const spinner = '/';
  static const places = '/places';
  static const addPlace = '/places/add';
  static String editPlace([int? id]) => '/places/edit/${id ?? ':id'}';
  static const fullscreenMap = '/fullscreenMap';
}