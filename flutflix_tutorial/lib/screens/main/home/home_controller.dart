import 'package:flutflix_tutorial/data/index.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _movieApi = MovieApi(service: MovieService.create());

  final isTrendingLoading = false.obs;
  final trendingMovies = <Movie>[].obs;

  final isTopRateLoading = false.obs;
  final topRatedMovies = <Movie>[].obs;

  final isUpcommingLoading = false.obs;
  final upcomingMovies = <Movie>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTrendingMovies();
    getTopRatedMovies();
    getUpcomingMovies();
    print('HomeController onInit called');
  }

  @override
  void onReady() {
    super.onReady();
    print('HomeController onReady called');
  }

  @override
  void onClose() {
    super.onClose();
    print('HomeController onClose called');
  }

  void getTrendingMovies() async {
    isTrendingLoading.value = true;
    try {
      trendingMovies.value = await _movieApi.getTrendingMovies();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isTrendingLoading.value = false;
    }
  }

  void getTopRatedMovies() async {
    isTopRateLoading.value = true;
    try {
      topRatedMovies.value = await _movieApi.getTopRatedMovies();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isTopRateLoading.value = false;
    }
  }

  void getUpcomingMovies() async {
    isUpcommingLoading.value = true;
    try {
      upcomingMovies.value = await _movieApi.getUpcomingMovies();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isUpcommingLoading.value = false;
    }
  }
}
