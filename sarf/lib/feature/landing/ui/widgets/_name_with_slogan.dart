part of '../../landing.dart';

class NameWithSlogan extends StatelessWidget {
  const NameWithSlogan({super.key});

  TextStyle? getStyle(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width <= 700) return context.h5;
    return context.h2;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,

      text: TextSpan(
        text: context.translate(key: 'app_name'),
        style: context.h1!.copyWith(
          color: Color(0xff4857FC),
          fontWeight: FontWeight.w700,
          height: 2.5,
        ),
        children: [
          TextSpan(
            text: '\n${context.translate(key: 'slogan')}',
            style: getStyle(context)!.copyWith(color: context.onSurface),
          ),
          TextSpan(
            text: '\n${context.translate(key: 'cta')}',
            style: getStyle(context)!.copyWith(color: Color(0xff4857FC)),
            children: [
              TextSpan(
                text:
                    '\n${context.read<AppLanguageCubit>().state.languageCode == 'en' ? '\n' : ' '}${context.translate(key: 'value_proposition')}',
                style: getStyle(context)!.copyWith(color: Color(0xff1DCD9F)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
