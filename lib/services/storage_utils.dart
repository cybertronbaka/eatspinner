import 'package:eatspinner/app/_all.dart';

class StorageUtils {
  static (String, String) getBucketAndPath(String path){
    List<String> list = path.split('/');
    final bucket = list.first;
    list.removeAt(0);
    return (bucket, list.join('/'));
  }

  static String getPublicUrl(String? path){
    if(path == null || path == '') return '';

    final (bucket, newPath) = getBucketAndPath(path);

    return supabase.storage.from(bucket).getPublicUrl(newPath);
  }
}