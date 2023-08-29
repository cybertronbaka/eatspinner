import 'package:eatspinner/app/globals.dart';
import 'package:eatspinner/models/profile/profile.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpParams{
  final String email;
  final String password;
  final String name;
  final int age;
  final String gender;
  // TODO: profile picture

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.gender
  });
}

class SignInParams {
  final String email;
  final String password;
  // TODO: add captcha

  SignInParams({
    required this.email,
    required this.password
  });
}

class AuthRepo {
  Future<void> signOut() async {
    await OneSignal.logout();
    await supabase.auth.signOut();
  }

  Future<void> signIn(SignInParams params) async {
    await supabase.auth.signInWithPassword(
      email: params.email.trim(),
      password: params.password
    );
    final cuid = supabase.auth.currentUser!.id;
    await OneSignal.login(cuid);
  }

  Future<void> signUp(SignUpParams params) async {
    final email = params.email.trim();
    Profile? profile;
    bool signedIn = false;
    try {
      profile = await ProfileRepo().create(Profile(
          userId: 'tmp',
          email: email,
          name: params.name,
          age: params.age,
          gender: params.gender
      ));
      final authRes = await supabase.auth.signUp(
        email: email,
        password: params.password,
      );
      signedIn = true;
      profile = await ProfileRepo().update(profile.copyWith(userId: authRes.user!.id));
    } catch(e) {
      if(profile != null) {
        await ProfileRepo().delete(profile.id!);
      }
      if(true){
        supabase.auth.signOut();
      }
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(
      email,
      // redirectTo: 'eatspinner://com.example.eatspinner/resetpassword'
      redirectTo: '${dotenv.env['NEXT_URL']!}/resetpassword'
      // redirectTo: 'http://localhost:3000/resetpassword'
    );
  }

  Future<void> updatePassword(String password) async {
    await supabase.auth.updateUser(UserAttributes(password: password));
  }
}