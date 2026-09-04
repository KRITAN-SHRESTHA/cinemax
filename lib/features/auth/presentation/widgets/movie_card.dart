import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.image,
    required this.title,
    required this.genre,
    required this.rating,
  });

  final String image;
  final String title;
  final String genre;
  final double rating;

  static const double width = 130;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //* The poster takes whatever the rail has left after the text, so
          //* the card cannot overflow when the labels grow.
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(image, fit: BoxFit.cover),
                  ),
                ),
                Positioned(top: 8, right: 8, child: _Rating(rating: rating)),
              ],
            ),
          ),
          8.verticalBox,
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textH4SemiBold.copyWith(color: kWhite),
          ),
          4.verticalBox,
          Text(genre, style: textH6Medium.copyWith(color: kGrey)),
        ],
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        //* Dimmed plate so the score stays legible over any poster.
        color: kBlack.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: kOrange, size: 16),
          4.horizontalBox,
          Text(rating.toString(), style: textH6Medium.copyWith(color: kOrange)),
        ],
      ),
    );
  }
}
