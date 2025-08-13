import 'package:flutter/material.dart';
import 'theme_presets.dart';

enum ScreenType { dashboard, list, form, detail, table }
enum StyleVariant { modern, classic, minimal, colorful, neumorphic, glass }

class TemplateConfig {
  Color primaryColor;
  Color secondaryColor;
  Color accentColor;
  Color backgroundColor;
  String fontFamily;
  double fontSize;
  FontWeight fontWeight;
  double letterSpacing;
  double lineHeight;
  BorderRadius borderRadius;
  double elevation;
  ScreenType screenType;
  StyleVariant styleVariant;
  bool useGradient;
  bool useShadows;
  bool useRoundedCorners;
  double iconSize;
  Color surfaceTintColor;
  double surfaceTintStrength;

  TemplateConfig({
    // Defaults inspired by a refined modern style
    this.primaryColor = const Color(0xFF5E81AC), // Nord Darker primary
    this.secondaryColor = const Color(0xFF4C566A), // Nord Darker secondary
    this.accentColor = const Color(0xFF8FBCBB), // Nord Darker accent
    this.backgroundColor = const Color(0xFFF7FAFC),
    this.fontFamily = 'Poppins',
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.letterSpacing = 0.1,
    this.lineHeight = 1.3,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.elevation = 3.0,
    this.screenType = ScreenType.list,
    this.styleVariant = StyleVariant.classic,
    this.useGradient = false,
    this.useShadows = false,
    this.useRoundedCorners = true,
    this.iconSize = 20.0,
    this.surfaceTintColor = const Color(0xFF000000),
    this.surfaceTintStrength = 0.05,
  });

  TemplateConfig copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    Color? backgroundColor,
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? lineHeight,
    BorderRadius? borderRadius,
    double? elevation,
    ScreenType? screenType,
    StyleVariant? styleVariant,
    bool? useGradient,
    bool? useShadows,
    bool? useRoundedCorners,
    double? iconSize,
    Color? surfaceTintColor,
    double? surfaceTintStrength,
  }) {
    return TemplateConfig(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      lineHeight: lineHeight ?? this.lineHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      screenType: screenType ?? this.screenType,
      styleVariant: styleVariant ?? this.styleVariant,
      useGradient: useGradient ?? this.useGradient,
      useShadows: useShadows ?? this.useShadows,
      useRoundedCorners: useRoundedCorners ?? this.useRoundedCorners,
      iconSize: iconSize ?? this.iconSize,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      surfaceTintStrength: surfaceTintStrength ?? this.surfaceTintStrength,
    );
  }

  factory TemplateConfig.fromPreset(ThemePreset preset) {
    final def = kThemePresets.firstWhere((p) => p.id == preset);
    return TemplateConfig(
      primaryColor: def.primary,
      secondaryColor: def.secondary,
      accentColor: def.accent,
      styleVariant: StyleVariant.classic,
      useRoundedCorners: true,
      useShadows: false,
      surfaceTintColor: const Color(0xFF000000),
      surfaceTintStrength: 0.05,
    );
  }
} 