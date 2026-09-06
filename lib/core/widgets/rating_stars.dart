import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Read-only star row, e.g. "4.0 out of 5" rendered as 4 filled + 1 empty star.
class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.size = 13, this.max = 5});

  final double rating;
  final double size;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(max, (i) {
        final filled = i < rating.round();
        return Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          size: size,
          color: filled ? AppColors.warning : AppColors.border,
        );
      }),
    );
  }
}

/// Interactive star picker used on the rating sheet.
class RatingStarsInput extends StatelessWidget {
  const RatingStarsInput({super.key, required this.rating, required this.onChanged, this.size = 30, this.max = 5});

  final int rating;
  final ValueChanged<int> onChanged;
  final double size;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(max, (i) {
        final value = i + 1;
        final filled = value <= rating;
        return IconButton(
          onPressed: () => onChanged(value),
          icon: Icon(
            filled ? Icons.star_rounded : Icons.star_border_rounded,
            size: size,
            color: filled ? AppColors.warning : AppColors.border,
          ),
        );
      }),
    );
  }
}
