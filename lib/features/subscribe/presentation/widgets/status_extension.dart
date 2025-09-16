import 'package:flutter/material.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/gen/assets.gen.dart';

extension StatusExtension on String {
  Widget getStatusIcon({double size = 20}) {
    switch (toLowerCase()) {
      case 'reject':
      case 'rejected':
        return Assets.icons.infoReject.svg(width: size, height: size);
      case 'approve':
      case 'approved':
        return Assets.icons.infoApproved.svg(width: size, height: size);
      case 'pending':
      default:
        return Assets.icons.infoPending.svg(width: size, height: size);
    }
  }

  Color getStatusColor() {
    switch (toLowerCase()) {
      case 'reject':
      case 'rejected':
        return const Color(0xffF57764);
      case 'approve':
      case 'approved':
        return AppColors.primary;
      case 'pending':
      default:
        return const Color(0xffF5C861);
    }
  }
}
