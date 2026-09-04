import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/core/utils/assets.dart';
import 'package:cinemax/core/utils/color.dart';
import 'package:cinemax/core/utils/extension.dart';
import 'package:cinemax/core/utils/string.dart';
import 'package:cinemax/core/utils/style.dart';
import 'package:cinemax/features/auth/presentation/widgets/category_chip.dart';
import 'package:cinemax/features/auth/presentation/widgets/featured_card.dart';
import 'package:cinemax/features/auth/presentation/widgets/greeting.dart';
import 'package:cinemax/features/auth/presentation/widgets/movie_rail.dart';
import 'package:cinemax/features/auth/presentation/widgets/page_indicator.dart';
import 'package:cinemax/features/auth/presentation/widgets/search_bar.dart';
import 'package:cinemax/features/auth/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';

typedef Featured = ({String image, String title, String date});

//* Placeholder line-up until the catalogue is wired in: swap these for real
//* stills and titles.
const List<Featured> _featured = [
  (
    image: kOnboarding1,
    title: 'Black Panther: Wakanda Forever',
    date: 'On March 2, 2022',
  ),
  (image: kBg, title: 'Life of Pi', date: 'On June 14, 2022'),
  (image: kImage, title: 'The Jungle Waiting', date: 'On July 8, 2022'),
];

typedef Movie = ({String image, String title, String genre, double rating});

//* Titles follow what each poster actually shows.
const List<Movie> movies = [
  (
    image: kComedy,
    title: 'Spider-Man No Way Home',
    genre: 'Action',
    rating: 4.5,
  ),
  (
    image: kDrama,
    title: 'The Jungle Waiting',
    genre: 'Documentary',
    rating: 4.5,
  ),
  (image: kAction, title: 'Riverdale', genre: 'Comedy', rating: 4.5),
];

const List<String> categories = [
  'All',
  'Action',
  'Comedy',
  'Animation',
  'Documentary',
];

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  //* Which card is centred, so the dots can follow it.
  int _currentIndex = 0;

  //* Index into _categories: 0 is "All", the rest match a genre.
  int _selectedCategory = 0;

  List<Movie> get _selectedMovies {
    if (_selectedCategory == 0) return movies;

    final String category = categories[_selectedCategory];
    return movies.where((movie) => movie.genre == category).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            16.verticalBox,
            const Greeting(),
            24.verticalBox,
            SearchBarWidget(controller: _searchController),
            24.verticalBox,
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: _featured.length,
              itemBuilder: (context, index, _) {
                final Featured item = _featured[index];
                return FeaturedCard(
                  image: item.image,
                  title: item.title,
                  date: item.date,
                );
              },
              options: CarouselOptions(
                height: 160,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) =>
                    setState(() => _currentIndex = index),
              ),
            ),
            16.verticalBox,
            Center(
              child: PageIndicator(
                itemCount: _featured.length,
                page: _currentIndex.toDouble(),
              ),
            ),
            32.verticalBox,
            Text(kCategories, style: textH4SemiBold.copyWith(color: kWhite)),
            16.verticalBox,
            CategoryChips(
              selected: _selectedCategory,
              onSelected: (index) => setState(() => _selectedCategory = index),
            ),
            24.verticalBox,
            SectionHeader(title: ''),
            16.verticalBox,
            MovieRail(movies: _selectedMovies),
            32.verticalBox,
            const SectionHeader(title: kMostPopular),
            16.verticalBox,
            const MovieRail(movies: movies),
            24.verticalBox,
          ],
        ).px(24),
      ),
    );
  }
}
