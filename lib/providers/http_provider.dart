import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/services/http_service.dart';
part 'http_provider.g.dart';

@Riverpod(keepAlive: true)
HttpService httpService(Ref ref) {
  return HttpService(ref);
}