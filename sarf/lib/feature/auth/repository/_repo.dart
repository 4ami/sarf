part of 'auth_repo.dart';

abstract interface class AuthRepoInterface {
  const AuthRepoInterface();

  Future<LoginResponse> login({required LoginRequest req});
  Future<RegisterResponse> register({required RegisterRequest req});
  Future<String> token({required String refToken});
}

final class AuthRepo implements AuthRepoInterface {
  AuthRepo();

  final HttpClient _client = HttpClient();

  @override
  Future<LoginResponse> login({required LoginRequest req}) async {
    return await _client.post(
      body: req,
      endpoint: CloudSource.login,
      parser: (res) => LoginResponse.fromJSON(res),
    );
  }

  @override
  Future<RegisterResponse> register({required RegisterRequest req}) async {
    return await _client.post(
      body: req,
      endpoint: CloudSource.register,
      parser: (res) => RegisterResponse.fromJSON(res),
    );
  }

  @override
  Future<String> token({required String refToken}) async {
    return await _client.post(
      body: _TokenRequest(),
      endpoint: CloudSource.token,
      parser: (res) => res['token'] ?? (res['message'] ?? 'None'),
      headers: {'Authorization': refToken},
    );
  }
}

class _TokenRequest extends BaseRequest {
  const _TokenRequest();
  @override
  Map<String, dynamic> toJSON() => {};
}
