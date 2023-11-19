import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/core/usecases/base_usecase.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';

class LoginUseCase extends BaseUseCase<DataState, UserEntity> {
  final IAuthRepository _authRepo;
  LoginUseCase(this._authRepo);

  @override
  Future<DataState> call({UserEntity? params}) {
    return _authRepo.login(params!.username!, params.password!);
  }
}
