part of '../../expenses_lib.dart';

class _NewExpenseForm extends StatefulWidget {
  const _NewExpenseForm();

  @override
  State<_NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<_NewExpenseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  int selectedCategoryId = 1;
  double amount = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 25,
              runSpacing: 35,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                CustomField(
                  width: width <= 700 ? 250 : null,
                  labelKey: 'add_expense_field_label',
                  validator: FieldsValidator.expenseField,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (p0) {
                    if (p0 == null || p0.isEmpty) return;
                    if (double.tryParse(p0) == null) return;
                    setState(() {
                      amount = double.parse(p0);
                    });
                  },
                ),

                SizedBox(
                  width: 250,
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value <= 0) {
                        return context.translate(key: 'required_field');
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle: context.titleLarge,
                      border: _border,
                      enabledBorder: _border,
                      label: Text(
                        context.translate(key: 'choose_spending_category'),
                      ),
                    ),
                    items: buildItems(),
                    onChanged: (i) {
                      setState(() {
                        if (i == null) return;
                        selectedCategoryId = i;
                      });
                    },
                    isExpanded: true,
                    value: selectedCategoryId,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: 250,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xff4857FC)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                  shape: WidgetStatePropertyAll(StadiumBorder()),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    context.read<SpendingsBloc>().add(
                      TriggerAddNewExpenses(
                        amount: amount,
                        category: selectedCategoryId,
                      ),
                    );
                  }
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>>? buildItems() {
    SpendingState state = context.watch<SpendingsBloc>().state;
    return state.categories.map((cat) {
      return DropdownMenuItem(
        value: cat.id,
        child: Row(
          children: [
            Image.asset(
              cat.icon,
              width: 20,
              height: 20,
              color: context.onSecondaryContainer,
            ),
            const SizedBox(width: 10),
            Text(context.translate(key: cat.labelKey)),
          ],
        ),
      );
    }).toList();
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: context.primary, width: 2.5),
    );
  }
}
