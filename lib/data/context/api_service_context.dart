import 'package:motelhub_flutter/data/api_service/area/area_api_service.dart';
import 'package:motelhub_flutter/data/api_service/auth/auth_api_service.dart';

class ApiServiceContext {
  final AreaApiService area;
  final AuthApiService auth;
  const ApiServiceContext(this.area, this.auth);
}