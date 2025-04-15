part of '../../landing.dart';

class _TopSection extends StatelessWidget {
  const _TopSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      spacing: 200,
      children: [
        NameWithSlogan(),
        Image.asset(AppAssets.assets.walletImage, width: 200),
      ],
    );
  }
}
