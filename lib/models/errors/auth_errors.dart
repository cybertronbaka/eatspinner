import 'package:eatspinner/models/_all.dart';

class UnauthenticatedError implements Exception{
  final String message;
  const UnauthenticatedError([this.message = ErrorMsgs.authUnauthenticated]);

  @override
  String toString() => message;
}

class UnauthorizedError implements Exception{
  final String message;
  const UnauthorizedError([this.message = ErrorMsgs.authUnauthorized]);

  @override
  String toString() => message;
}