import 'package:eatspinner/app/globals.dart';

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
    await supabase.auth.signOut();
  }

  Future<void> signIn(SignInParams params) async {
    await supabase.auth.signInWithPassword(
      email: params.email.trim(),
      password: params.password
    );
  }

  Future<void> signUp(SignUpParams params) async {
    await supabase.auth.signUp(
      email: params.email.trim(),
      password: params.password,
      data: {
        'email': params.email.trim(),
        'name': params.name,
        'age': params.age,
        'gender': params.gender
      }
    );
  }

  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }
}