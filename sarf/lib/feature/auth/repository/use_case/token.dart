part of '../auth_repo.dart';

final class TokenUseCase {
  TokenUseCase();
  final AuthRepo _repo = AuthRepo();

  Future<String> execute({required String refToken}) async {
    return await _repo.token(refToken: refToken);
  }
}
