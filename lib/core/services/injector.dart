import 'package:cinemax/config/routes/routes.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
Future<void> injectDependencies() async {
  getIt.registerLazySingleton<AppRouter>(AppRouter.new);
}
