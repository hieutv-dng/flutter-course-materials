import 'package:flutflix_tutorial/data/index.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieListController extends GetxController {
  final _movieApi = MovieApi(service: MovieService.create());
  final state = const BaseState.initial().obs;

  //Paging data
  final PagingController<int, Movie> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
  }

  void fetchData(int pageKey) async {
    state.value = state.value.copyWith(status: BaseStatus.loading);
    try {
      final movies = await _movieApi.getTrendingMovies(page: pageKey);
      if (movies.isNotEmpty) {
        pagingController.appendPage(movies, pageKey + 1);
      } else {
        pagingController.appendLastPage([]);
      }
      state.value = state.value.copyWith(status: BaseStatus.success);
    } catch (e) {
      pagingController.error = e;
      state.value = state.value.copyWith(
        status: BaseStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }
}
