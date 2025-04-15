part of '../../landing.dart';

class NameWithSlogan extends StatelessWidget {
  const NameWithSlogan({super.key});

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
            style: context.h2!.copyWith(color: context.onSurface),
          ),
          TextSpan(
            text: '\n${context.translate(key: 'cta')}',
            style: context.h2!.copyWith(color: Color(0xff4857FC)),
            children: [
              TextSpan(
                text:
                    '${context.read<AppLanguageCubit>().state.languageCode == 'en' ? '\n' : ' '}${context.translate(key: 'value_proposition')}',
                style: context.h2!.copyWith(color: Color(0xff1DCD9F)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
