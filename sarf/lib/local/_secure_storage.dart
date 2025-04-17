part of 'local_storage.dart';

class SS {
  SS._internal();

  static final SS _ = SS._internal();
  static SS get instance => _;

  final FlutterSecureStorage _ss = FlutterSecureStorage();

  Future<String?> read(String key) async {
    return await _ss.read(key: key);
  }

  Future<void> write({required String key, required String value}) async {
    await _ss.write(key: key, value: value);
  }

  Future<void> delete({required String key}) async {
    await _ss.delete(key: key);
  }

  Future<bool> isStored({required String key}) async {
    String? value = await _ss.read(key: key);
    return !(value == null) && (value.isNotEmpty);
  }

  Future<void> writeBudget({required double budget}) async {
    await _ss.write(key: 'budget', value: budget.toString());
  }

  Future<double> readBudget() async {
    String? budget = await _ss.read(key: 'budget');
    if (budget == null) return 0;

    if (double.tryParse(budget) == null) return 0;

    return double.parse(budget);
  }
}
