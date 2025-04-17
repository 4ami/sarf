part of '../../budget_lib.dart';

class _CurrentBudget extends StatelessWidget {
  const _CurrentBudget();

  @override
  Widget build(BuildContext context) {
    String label = context.translate(key: 'user_current_budget_label');
    double budget = context.watch<SpendingsBloc>().state.budget;
    String currency = context.translate(key: 'currency_name');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.surface.withValues(alpha: .6),
            context.inversePrimary.withValues(alpha: .6),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$label: ${budget.toStringAsFixed(2)} $currency',
        style: context.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
