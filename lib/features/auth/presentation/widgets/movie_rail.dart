import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/pages/home_page.dart';
import 'package:cinemax/features/auth/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MovieRail extends StatelessWidget {
  const MovieRail({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return SizedBox(
        height: 232,
        child: Center(
          child: Text(kNoMoviesYet, style: textH5Medium.copyWith(color: kGrey)),
        ),
      );
    }

    return SizedBox(
      height: 232,
      child: OverflowBox(
        maxWidth: MediaQuery.sizeOf(context).width,

        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: 24.horizontal,
          itemCount: movies.length,
          separatorBuilder: (context, index) => 12.horizontalBox,
          itemBuilder: (context, index) {
            final Movie movie = movies[index];
            return MovieCard(
              image: movie.image,
              title: movie.title,
              genre: movie.genre,
              rating: movie.rating,
            );
          },
        ),
      ),
    );
  }
}
