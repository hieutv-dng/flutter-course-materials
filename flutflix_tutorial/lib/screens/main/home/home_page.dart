import 'package:flutflix_tutorial/data/models/movie.dart';
import 'package:flutflix_tutorial/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
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
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
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
          if (controller.isTrendingLoading.value) {
            return const CircularProgressIndicator();
          }
          return MoviesSlider(movies: controller.trendingMovies);
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
          if (controller.isTopRateLoading.value) {
            return const CircularProgressIndicator();
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
          if (controller.isUpcommingLoading.value) {
            return const CircularProgressIndicator();
          }
          return MoviesSlider(movies: controller.upcomingMovies);
        }),
      ],
    );
  }
}
