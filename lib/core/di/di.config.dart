// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/api/exam_api_client.dart' as _i146;
import '../../data/datasource/contract/auth_datasource.dart' as _i534;
import '../../data/datasource/impl/auth_datasource_impl.dart' as _i55;
import '../../data/mapper/auth_mapper.dart' as _i807;
import '../../data/repo/auth_repo_impl.dart' as _i0;
import '../../domain/repo/auth_repo.dart' as _i716;
import '../../domain/use_case/login_use_case.dart' as _i461;
import '../../domain/use_case/signup_use_case.dart' as _i363;
import '../../presentation/login/cubit/login_cubit.dart' as _i101;
import '../../presentation/signup/cubit/sign_up_cubit.dart' as _i843;
import '../app_config_provider.dart' as _i451;
import '../network/auth_interceptor.dart' as _i908;
import '../theme/app_colors.dart' as _i57;
import '../theme/app_theme.dart' as _i1025;
import 'network_module.dart' as _i567;
import 'storage_module.dart' as _i371;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.getSharedPref(),
      preResolve: true,
    );
    gh.factory<_i807.AuthMapper>(() => _i807.AuthMapper());
    gh.singleton<_i361.Dio>(() => networkModule.provideDio());
    gh.factory<_i57.AppColors>(() => _i57.LightThemeColors());
    gh.singleton<_i451.AppConfigProvider>(
      () => _i451.AppConfigProvider(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i908.AuthInterceptor>(
      () => _i908.AuthInterceptor(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i1025.AppTheme>(() => _i1025.AppTheme(gh<_i57.AppColors>()));
    gh.singleton<_i146.ExamApiClient>(
      () => _i146.ExamApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i534.AuthDatasource>(
      () => _i55.AuthDatasourceImpl(gh<_i146.ExamApiClient>()),
    );
    gh.lazySingleton<_i716.AuthRepo>(
      () => _i0.AuthRepoImpl(
        gh<_i534.AuthDatasource>(),
        gh<_i807.AuthMapper>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i461.LoginUseCase>(
      () => _i461.LoginUseCase(gh<_i716.AuthRepo>()),
    );
    gh.factory<_i363.SignUseCase>(
      () => _i363.SignUseCase(gh<_i716.AuthRepo>()),
    );
    gh.factory<_i101.LoginCubit>(
      () => _i101.LoginCubit(
        gh<_i461.LoginUseCase>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i843.SignUpCubit>(
      () => _i843.SignUpCubit(gh<_i363.SignUseCase>()),
    );
    return this;
  }
}

class _$StorageModule extends _i371.StorageModule {}

class _$NetworkModule extends _i567.NetworkModule {}
