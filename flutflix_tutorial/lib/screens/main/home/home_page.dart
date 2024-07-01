import 'package:flutflix_tutorial/data/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'movies_carousel_slider.dart';
import 'movies_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    _controller = Get.put(HomeController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/flutflix.png',
          fit: BoxFit.cover,
          height: 40,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            _controller.fetchData();
            return Future.delayed(Duration.zero);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _TrendingMovies(),
              SizedBox(height: 32),
              _TopRatedMovies(),
              SizedBox(height: 32),
              _UpcomingMovies(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendingMovies extends GetView<HomeController> {
  const _TrendingMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Trending Movies', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 32),
        Obx(() {
          if (controller.trendingState.value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.trendingState.value.isFailure) {
            return Text(controller.trendingState.value.errorMessage ?? '');
          }
          return MoviesCarouselSlider(movies: controller.trendingMovies);
        }),
      ],
    );
  }
}

class _TopRatedMovies extends GetView<HomeController> {
  const _TopRatedMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Top Rated Movies', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 32),
        Obx(() {
          if (controller.topRatedState.value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.topRatedState.value.isFailure) {
            return Text(controller.topRatedState.value.errorMessage ?? '');
          }
          return MoviesSlider(movies: controller.topRatedMovies);
        }),
      ],
    );
  }
}

class _UpcomingMovies extends GetView<HomeController> {
  const _UpcomingMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upcoming Movies', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 32),
        Obx(() {
          if (controller.upcomingState.value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.upcomingState.value.isFailure) {
            return Text(controller.upcomingState.value.errorMessage ?? '');
          }
          return MoviesSlider(movies: controller.upcomingMovies);
        }),
      ],
    );
  }
}
