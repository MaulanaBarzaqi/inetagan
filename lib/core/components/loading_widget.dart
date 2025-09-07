import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inetagan/core/config/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? strokeWidth;
  const LoadingWidget({
    super.key,
    this.size = 36.0,
    this.color,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    final indicator = CircularProgressIndicator(
      strokeWidth: strokeWidth ?? 3.0,
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? Theme.of(context).primaryColor,
      ),
    );
    return Center(
      child: SizedBox(width: size, height: size, child: indicator),
    );
  }
}

class FullScreenDialogLoader {
  static bool _isLoadingOpen = false;

  static void show(BuildContext context) {
    if (!_isLoadingOpen) {
      _isLoadingOpen = true;
      WidgetsBinding.instance.addPersistentFrameCallback((_) {
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.transparent,
            builder: (BuildContext context) {
              return PopScope(
                canPop: false,
                child: Center(
                  child: SpinKitCircle(color: AppColors.primary, size: 50),
                ),
              );
            },
          ).then((_) {
            _isLoadingOpen = false;
          });
        }
      });
    }
  }
}
