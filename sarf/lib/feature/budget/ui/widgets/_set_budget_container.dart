part of '../../budget_lib.dart';

class _SetBudgetContainer extends StatefulWidget {
  const _SetBudgetContainer();

  @override
  State<_SetBudgetContainer> createState() => __SetBudgetContainerState();
}

class __SetBudgetContainerState extends State<_SetBudgetContainer> {
  double amount = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.inversePrimary.withValues(alpha: .4),
              context.surface.withValues(alpha: .4),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.translate(key: 'budget_form_title'),
                style: context.titleMedium,
              ),
              SizedBox(height: 50),
              CustomField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                labelKey: 'budget_field_label',
                onChanged: (p0) {
                  if (p0 == null || p0.isEmpty) return;
                  if (double.tryParse(p0) == null) return;
                  setState(() {
                    amount = double.parse(p0);
                  });
                },
              ),
              SizedBox(height: 80),
              SizedBox(
                width: 250,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xff4857FC)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                    shape: WidgetStatePropertyAll(StadiumBorder()),
                  ),
                  onPressed: () {
                    context.read<SpendingsBloc>().add(
                      TriggerStoreBudget(budget: amount),
                    );
                  },
                  child: Text(context.translate(key: 'save_budget_button')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
