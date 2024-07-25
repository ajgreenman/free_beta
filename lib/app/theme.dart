import 'package:flutter/material.dart';

class FreeBetaTheme {
  static final ThemeData blueTheme = ThemeData(
    scaffoldBackgroundColor: FreeBetaColors.grayBackground,
    appBarTheme: AppBarTheme(
      color: FreeBetaColors.black,
      titleTextStyle: FreeBetaTextStyle.h3.copyWith(
        color: FreeBetaColors.white,
      ),
      elevation: 1,
      iconTheme: IconThemeData(
        color: FreeBetaColors.black,
      ),
    ),
    canvasColor: FreeBetaColors.grayBackground,
    colorScheme: ColorScheme(
      primary: FreeBetaColors.black,
      secondary: FreeBetaColors.green,
      surface: FreeBetaColors.grayBackground,
      error: FreeBetaColors.red,
      onPrimary: FreeBetaColors.white,
      onSecondary: FreeBetaColors.black,
      onSurface: FreeBetaColors.black,
      onError: FreeBetaColors.red,
      brightness: Brightness.light,
    ),
    disabledColor: FreeBetaColors.grayLight,
    textTheme: ThemeData.light().textTheme,
    unselectedWidgetColor: FreeBetaColors.black,
    dividerTheme: DividerThemeData(color: FreeBetaColors.black),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: FreeBetaColors.white,
    ),
  );
}

class FreeBetaColors {
  static const black = Color(0xFF000000);
  static const chalkboard = Color(0xFF293340);

  static const blueLight = Color(0xFF296AFF);
  static const blue = Color(0xFF143A91);
  static const blueDark = Color(0xFF001239);

  static const brown = Color(0xFFB37B2C);

  static const grayBackground = Color(0xFFF0F0F0);
  static const grayLight = Color(0xFFC7C8CA);
  static const gray = Color(0xFF8A8D8F);
  static const grayDark = Color(0xFF414042);

  static const greenFilterBar = Color(0xFFCAFAEB);
  static const greenBrand = Color(0xFF78FFD4);
  static const green = Color(0xFF16BD00);
  static const greenDark = Color(0xFF0C784C);

  static const pink = Color(0xFFFC5DE5);

  static const purpleFilterBar = Color(0xFFEFCAFC);
  static const purpleBrand = Color(0xFFC161E4);
  static const purple = Color(0xFF630085);
  static const purpleDark = Color(0xFF371343);
  static const purpleExtraDark = Color(0xFF240030);

  static const red = Color(0xFFFF333D);

  static const wallColor = Color(0xFFC3BEAF);

  static const warning = Color(0xFFFFA600);

  static const white = Color(0xFFFFFFFF);

  static const yellowFilterBar = Color(0xFFFCFFCF);
  static const yellowBrand = Color(0xFFF2FC62);
  static const yellowLight = Color(0xFFFCFFCC);
}

class FreeBetaGradients {
  static const filterBar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      FreeBetaColors.yellowFilterBar,
      FreeBetaColors.greenFilterBar,
      FreeBetaColors.purpleFilterBar,
    ],
    stops: [
      0.0,
      0.7,
      0.9,
    ],
  );

  static const reverseFilterBar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      FreeBetaColors.purpleFilterBar,
      FreeBetaColors.greenFilterBar,
      FreeBetaColors.yellowFilterBar,
    ],
    stops: [
      0.0,
      0.7,
      0.9,
    ],
  );

  static const highlight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      FreeBetaColors.yellowFilterBar,
      FreeBetaColors.greenFilterBar,
      FreeBetaColors.purpleFilterBar,
    ],
    stops: [
      0.0,
      0.3,
      0.6,
    ],
  );
}

class FreeBetaSizes {
  /// Size of 0.
  static const none = 0.0;

  /// Size of 1.
  static const xxs = 1.0;

  /// Size of 2.
  static const xs = 2.0;

  /// Size of 4.
  static const s = 4.0;

  /// Size of 8.
  static const m = 8.0;

  /// Size of 12.
  static const ml = 12.0;

  /// Size of 16.
  static const l = 16.0;

  /// Size of 24.
  static const xl = 24.0;

  /// Size of 32.
  static const xxl = 32.0;

  /// Size of 64.
  static const xxxl = 64.0;

  /// Size of 128.
  static const xxxxl = 128.0;
}

class FreeBetaPadding {
  static const xsHorizontal =
      EdgeInsets.symmetric(horizontal: FreeBetaSizes.xs);
  static const sHorizontal = EdgeInsets.symmetric(horizontal: FreeBetaSizes.s);
  static const mHorizontal = EdgeInsets.symmetric(horizontal: FreeBetaSizes.m);
  static const mlHorizontal =
      EdgeInsets.symmetric(horizontal: FreeBetaSizes.ml);
  static const lHorizontal = EdgeInsets.symmetric(horizontal: FreeBetaSizes.l);
  static const xlHorizontal =
      EdgeInsets.symmetric(horizontal: FreeBetaSizes.xl);
  static const xxlHorizontal =
      EdgeInsets.symmetric(horizontal: FreeBetaSizes.xxl);
  static const xxxlHorizontal =
      EdgeInsets.symmetric(horizontal: FreeBetaSizes.xxxl);

  static const xsVerticle = EdgeInsets.symmetric(vertical: FreeBetaSizes.xs);
  static const sVertical = EdgeInsets.symmetric(vertical: FreeBetaSizes.s);
  static const mVertical = EdgeInsets.symmetric(vertical: FreeBetaSizes.m);
  static const mlVertical = EdgeInsets.symmetric(vertical: FreeBetaSizes.ml);
  static const lVertical = EdgeInsets.symmetric(vertical: FreeBetaSizes.l);
  static const xlVertical = EdgeInsets.symmetric(vertical: FreeBetaSizes.xl);
  static const xxlVertical = EdgeInsets.symmetric(vertical: FreeBetaSizes.xxl);
  static const xxxlVertical =
      EdgeInsets.symmetric(vertical: FreeBetaSizes.xxxl);

  static const xsAll = EdgeInsets.all(FreeBetaSizes.xs);
  static const sAll = EdgeInsets.all(FreeBetaSizes.s);
  static const mAll = EdgeInsets.all(FreeBetaSizes.m);
  static const mlAll = EdgeInsets.all(FreeBetaSizes.ml);
  static const lAll = EdgeInsets.all(FreeBetaSizes.l);
  static const xlAll = EdgeInsets.all(FreeBetaSizes.xl);
  static const xxlAll = EdgeInsets.all(FreeBetaSizes.xxl);
  static const xxxlAll = EdgeInsets.all(FreeBetaSizes.xxxl);
}

class FreeBetaTextStyle {
  static const fontFamily = 'GTA';
  static const monoFontFamily = 'GTAM';

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.2222,
    color: FreeBetaColors.black,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.286,
    color: FreeBetaColors.black,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 22,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    height: 1.37,
    color: FreeBetaColors.black,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.4444,
    color: FreeBetaColors.black,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: FreeBetaColors.black,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 1.6,
    fontWeight: FontWeight.w400,
    color: FreeBetaColors.black,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.55,
    color: FreeBetaColors.black,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.625,
    fontWeight: FontWeight.w400,
    color: FreeBetaColors.black,
  );

  static const TextStyle body4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.428,
    color: FreeBetaColors.black,
  );

  static const TextStyle body5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3333,
    color: FreeBetaColors.black,
  );

  static const TextStyle body6 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8,
    fontWeight: FontWeight.w400,
    height: 1.25,
    color: FreeBetaColors.black,
  );

  static const TextStyle mono = TextStyle(
    fontFamily: monoFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.625,
    color: FreeBetaColors.black,
  );
}

class FreeBetaShadows {
  static final BoxShadow fluffy = BoxShadow(
    color: FreeBetaColors.black.withOpacity(0.1),
    blurRadius: 25.0,
    offset: Offset(0, 10),
  );
}
