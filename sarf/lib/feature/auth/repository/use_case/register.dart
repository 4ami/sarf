part of '../auth_repo.dart';

final class RegisterUseCase {
  RegisterUseCase() : _repo = AuthRepo();

  final AuthRepo _repo;

  Future<RegisterResponse> execute({required RegisterRequest req}) async {
    return _repo.register(req: req);
  }
}
