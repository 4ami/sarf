part of '../shared_widgets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 15),
        child: Center(
          child: Lottie.asset(
            AppAssets.assets.loadingAnimation,
            width: 150,
            frameRate: FrameRate(60),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
