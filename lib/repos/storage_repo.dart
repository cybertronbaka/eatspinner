import 'dart:io';

import 'package:eatspinner/app/globals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageRepo {
  Future<String> upload(String path, String fileName, String uploadPath, {String bucket = 'public_files'}) async {
    final String url = await supabase.storage.from(bucket).upload(
      '$uploadPath/$fileName',
      File(path),
      fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
    );
    return url;
  }

  Future<void> delete(String path, {String bucket = 'public_files', bool throwError = true}) async{
    try{
      await supabase.storage.from(bucket).remove([path]);
    }catch(e){
      if(throwError) rethrow;
    }
  }

  Future<void> deleteList(List<String> path, {String bucket = 'public_files', bool throwError = true}) async{
    try{
      await supabase.storage.from(bucket).remove(path);
    }catch(e){
      if(throwError) rethrow;
    }
  }
}