part of '../../landing.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    PopupMenuItem<String> buildItem(String langCode) {
      return PopupMenuItem<String>(
        value: langCode,
        child: Text(context.translate(key: 'lang_$langCode')),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: context.inversePrimary, width: 2),
        borderRadius: BorderRadius.circular(16),
        color: context.surface,
      ),
      child: PopupMenuButton<String>(
        tooltip:
            context.watch<AppLanguageCubit>().state.languageCode.toUpperCase(),
        offset: Offset(15, 40),
        icon: Icon(Icons.language),
        itemBuilder: (context) => [buildItem('ar'), buildItem('en')],
        onSelected: (b) {
          AppLanguageCubit cubit = context.read<AppLanguageCubit>();
          if (b == 'ar') {
            cubit.toAR();
            return;
          }
          cubit.toEN();
        },
      ),
    );
  }
}
