// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow-left.svg
  SvgGenImage get arrowLeft => const SvgGenImage('assets/icons/arrow-left.svg');

  /// File path: assets/icons/bill.svg
  SvgGenImage get bill => const SvgGenImage('assets/icons/bill.svg');

  /// File path: assets/icons/calendar.svg
  SvgGenImage get calendar => const SvgGenImage('assets/icons/calendar.svg');

  /// File path: assets/icons/card.svg
  SvgGenImage get card => const SvgGenImage('assets/icons/card.svg');

  /// File path: assets/icons/chevron-right.svg
  SvgGenImage get chevronRight =>
      const SvgGenImage('assets/icons/chevron-right.svg');

  /// File path: assets/icons/circle-user.svg
  SvgGenImage get circleUser =>
      const SvgGenImage('assets/icons/circle-user.svg');

  /// File path: assets/icons/ellipsis-vertical.svg
  SvgGenImage get ellipsisVertical =>
      const SvgGenImage('assets/icons/ellipsis-vertical.svg');

  /// File path: assets/icons/eye-closed.svg
  SvgGenImage get eyeClosed => const SvgGenImage('assets/icons/eye-closed.svg');

  /// File path: assets/icons/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/eye.svg');

  /// File path: assets/icons/icEditProfile.svg
  SvgGenImage get icEditProfile =>
      const SvgGenImage('assets/icons/icEditProfile.svg');

  /// File path: assets/icons/icLogout.svg
  SvgGenImage get icLogout => const SvgGenImage('assets/icons/icLogout.svg');

  /// File path: assets/icons/info-approved.svg
  SvgGenImage get infoApproved =>
      const SvgGenImage('assets/icons/info-approved.svg');

  /// File path: assets/icons/info-pending.svg
  SvgGenImage get infoPending =>
      const SvgGenImage('assets/icons/info-pending.svg');

  /// File path: assets/icons/info-reject.svg
  SvgGenImage get infoReject =>
      const SvgGenImage('assets/icons/info-reject.svg');

  /// File path: assets/icons/location.svg
  SvgGenImage get location => const SvgGenImage('assets/icons/location.svg');

  /// File path: assets/icons/lock-keyhole.svg
  SvgGenImage get lockKeyhole =>
      const SvgGenImage('assets/icons/lock-keyhole.svg');

  /// File path: assets/icons/mail.svg
  SvgGenImage get mail => const SvgGenImage('assets/icons/mail.svg');

  /// File path: assets/icons/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/icons/phone.svg');

  /// File path: assets/icons/sliders-horizontal.svg
  SvgGenImage get slidersHorizontal =>
      const SvgGenImage('assets/icons/sliders-horizontal.svg');

  /// File path: assets/icons/square-check-big.svg
  SvgGenImage get squareCheckBig =>
      const SvgGenImage('assets/icons/square-check-big.svg');

  /// File path: assets/icons/usd-circle.svg
  SvgGenImage get usdCircle => const SvgGenImage('assets/icons/usd-circle.svg');

  /// File path: assets/icons/user-round.svg
  SvgGenImage get userRound => const SvgGenImage('assets/icons/user-round.svg');

  /// File path: assets/icons/wallet.svg
  SvgGenImage get wallet => const SvgGenImage('assets/icons/wallet.svg');

  /// File path: assets/icons/wifi-cog.svg
  SvgGenImage get wifiCog => const SvgGenImage('assets/icons/wifi-cog.svg');

  /// File path: assets/icons/wifi-off.svg
  SvgGenImage get wifiOff => const SvgGenImage('assets/icons/wifi-off.svg');

  /// File path: assets/icons/wifi-pen.svg
  SvgGenImage get wifiPen => const SvgGenImage('assets/icons/wifi-pen.svg');

  /// File path: assets/icons/wifi.svg
  SvgGenImage get wifi => const SvgGenImage('assets/icons/wifi.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    arrowLeft,
    bill,
    calendar,
    card,
    chevronRight,
    circleUser,
    ellipsisVertical,
    eyeClosed,
    eye,
    icEditProfile,
    icLogout,
    infoApproved,
    infoPending,
    infoReject,
    location,
    lockKeyhole,
    mail,
    phone,
    slidersHorizontal,
    squareCheckBig,
    usdCircle,
    userRound,
    wallet,
    wifiCog,
    wifiOff,
    wifiPen,
    wifi,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_failed.png
  AssetGenImage get imgFailed =>
      const AssetGenImage('assets/images/img_failed.png');

  /// File path: assets/images/img_logo_inetagan.png
  AssetGenImage get imgLogoInetagan =>
      const AssetGenImage('assets/images/img_logo_inetagan.png');

  /// File path: assets/images/img_splashscreen.png
  AssetGenImage get imgSplashscreen =>
      const AssetGenImage('assets/images/img_splashscreen.png');

  /// File path: assets/images/img_success.png
  AssetGenImage get imgSuccess =>
      const AssetGenImage('assets/images/img_success.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    imgFailed,
    imgLogoInetagan,
    imgSplashscreen,
    imgSuccess,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
