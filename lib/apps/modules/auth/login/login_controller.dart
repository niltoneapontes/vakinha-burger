import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vakinha_burger_mobile/apps/core/exceptions/user_not_found_exception.dart';
import 'package:vakinha_burger_mobile/apps/core/mixin/loader_mixin.dart';
import 'package:vakinha_burger_mobile/apps/core/mixin/messages_mixin.dart';
import 'package:vakinha_burger_mobile/apps/repositories/auth/auth_repository.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final AuthRepository _authRepository;

  LoginController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final loading = false.obs;
  final message = Rxn<MessageModel>();

  @override
  void onInit() {
    loaderListener(loading);
    messageListener(message);
    super.onInit();
  }

  Future<void> login({required String email, required String password}) async {
    try {
      loading.toggle();
      final userLogged = await _authRepository.login(email, password);
      final storage = GetStorage();
      storage.write('/USER_KEY/', userLogged.id);
      loading.toggle();
    } on UserNotFoundException catch (e, s) {
      loading.toggle();
      log('Login ou senha inválidos', error: e, stackTrace: s);
      message(
        MessageModel(
            title: 'Erro',
            message: 'Login e/ou senha inválidos',
            type: MessageType.error),
      );
    } catch (e, s) {
      loading.toggle();
      log('Login ou senha inválidos', error: e, stackTrace: s);
      message(
        MessageModel(
            title: 'Erro',
            message: 'Login e/ou senha inválidos',
            type: MessageType.error),
      );
    }
  }
}
