import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/providers/http_provider.dart';
import 'package:store/repositories/auth_repository.dart';
import 'package:store/services/auth_service.dart';
part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final httpService = ref.read(httpServiceProvider);
  return AuthService(httpService);
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final service = ref.watch(authServiceProvider);
  return AuthRepository(service);
}