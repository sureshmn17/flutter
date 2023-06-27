import 'package:flutter_mvvm_code/app/app_prefs.dart';
import 'package:flutter_mvvm_code/data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm_code/data/network/app_api.dart';
import 'package:flutter_mvvm_code/data/network/dio_factory.dart';
import 'package:flutter_mvvm_code/data/network/network_info.dart';
import 'package:flutter_mvvm_code/data/repository/repository_impl.dart';
import 'package:flutter_mvvm_code/domain/repository/repository.dart';
import 'package:flutter_mvvm_code/domain/usecase/login_usecase.dart';
import 'package:flutter_mvvm_code/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance =GetIt.instance;

Future<void> initAppModule() async{

  final sharedPrefs= await SharedPreferences.getInstance();

  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service client
  final dio= await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSouce>(() => RemoteDataSourceImplemeter(instance()));

  //repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance()));

}

intitLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}