import 'package:flutter/material.dart';
import '../constants/dimensions.dart';

class CardStyles extends ThemeExtension<CardStyles> {
  final BoxDecoration cardDecoration;
  final EdgeInsets cardPadding;
  final BorderRadius cardBorderRadius;

  const CardStyles({
    required this.cardDecoration,
    required this.cardPadding,
    required this.cardBorderRadius,
  });

  @override
  ThemeExtension<CardStyles> copyWith({
    BoxDecoration? cardDecoration,
    EdgeInsets? cardPadding,
    BorderRadius? cardBorderRadius,
  }) {
    return CardStyles(
      cardDecoration: cardDecoration ?? this.cardDecoration,
      cardPadding: cardPadding ?? this.cardPadding,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
    );
  }

  @override
  ThemeExtension<CardStyles> lerp(
    ThemeExtension<CardStyles>? other,
    double t,
  ) {
    if (other is! CardStyles) {
      return this;
    }
    return CardStyles(
      cardDecoration:
          BoxDecoration.lerp(cardDecoration, other.cardDecoration, t)!,
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
      cardBorderRadius: BorderRadius.lerp(
        cardBorderRadius,
        other.cardBorderRadius,
        t,
      )!,
    );
  }

  static const light = CardStyles(
    cardDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusMd)),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    cardPadding: EdgeInsets.all(Dimensions.md),
    cardBorderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusMd)),
  );
}
