part of 'cloud_lib.dart';

class CloudSource {
  static final String host = const String.fromEnvironment(
    'HOST',
    defaultValue: 'Failed to load HOST',
  );

  static final String login = const String.fromEnvironment(
    'AUTH_LOG',
    defaultValue: 'Failed to load AUTH_LOG',
  );
  static final String register = const String.fromEnvironment(
    'AUTH_REG',
    defaultValue: 'Failed to load AUTH_REG',
  );
  static final String token = const String.fromEnvironment(
    'AUTH_TOK',
    defaultValue: 'Failed to load AUTH_TOK',
  );

  static final String getCategories = const String.fromEnvironment(
    'GET_CAT',
    defaultValue: 'Failed to load GET_CAT',
  );
  static final String setBudget = const String.fromEnvironment(
    'SET_BUD',
    defaultValue: 'Failed to load SET_BUD',
  );

  static final String addExpense = const String.fromEnvironment(
    'ADD_EXP',
    defaultValue: 'Failed to load ADD_EXP',
  );
  static final String expenseRange = const String.fromEnvironment(
    'EXP_RANGE',
    defaultValue: 'Failed to load EXP_RANGE',
  );


  // static final String host = dotenv.get('HOST');

  // static final String login = dotenv.get('AUTH_LOG');
  // static final String register = dotenv.get('AUTH_REG');
  // static final String token = dotenv.get('AUTH_TOK');

  // static final String getCategories = dotenv.get('GET_CAT');
  // static final String setBudget = dotenv.get('SET_BUD');

  // static final String addExpense = dotenv.get('ADD_EXP');
  // static final String expenseRange = dotenv.get('EXP_RANGE');
}
