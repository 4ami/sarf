part of '../auth_repo.dart';

final class AuthLoginUseCase {
  AuthLoginUseCase() : _repo = AuthRepo();
  final AuthRepo _repo;

  
  Future<LoginResponse> execute({required LoginRequest req}) async {
    return await _repo.login(req: req);
  }
}
