part of 'cloud_lib.dart';

class CloudSource {
  static final String host = dotenv.get('HOST');

  static final String login = dotenv.get('AUTH_LOG');
  static final String register = dotenv.get('AUTH_REG');
  static final String token = dotenv.get('AUTH_TOK');

  static final String getCategories = dotenv.get('GET_CAT');
  static final String setBudget = dotenv.get('SET_BUD');

  static final String addExpense = dotenv.get('ADD_EXP');
  static final String expenseRange = dotenv.get('EXP_RANGE');
}