import 'package:flutflix_tutorial/data/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'movie_list_controller.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  late final MovieListController _controller;

  @override
  void initState() {
    _controller = Get.put(MovieListController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MovieListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
      ),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return PagedListView(
      pagingController: _controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Movie>(
        itemBuilder: (context, movie, index) {
          return ListTile(
            leading: Image.network(movie.posterPathUrl),
            title: Text(movie.title),
            subtitle: Text(movie.overview),
          );
        },
        firstPageErrorIndicatorBuilder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Something went wrong'),
                TextButton(
                  onPressed: () => _controller.pagingController.refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No movies found'),
              ],
            ),
          );
        },
      ),
    );
  }
}
