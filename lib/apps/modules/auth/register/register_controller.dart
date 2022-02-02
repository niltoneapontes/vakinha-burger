import 'dart:developer';

import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/mixin/loader_mixin.dart';
import 'package:vakinha_burger_mobile/apps/core/mixin/messages_mixin.dart';
import 'package:vakinha_burger_mobile/apps/core/rest_client/rest_client.dart';
import 'package:vakinha_burger_mobile/apps/modules/auth/repositories/auth/auth_repository.dart';

class RegisterController extends GetxController
    with LoaderMixin, MessagesMixin {
  final AuthRepository _authRepository;

  final loading = false.obs;
  final message = Rxn<MessageModel>();

  RegisterController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  void onInit() {
    loaderListener(loading);
    messageListener(message);
    super.onInit();
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      loading.toggle();
      final userModel = await _authRepository.register(name, email, password);
      loading.toggle();
      // TODO: Voltar quando fizer login
      Get.back();
      message(
        MessageModel(
            title: 'Sucesso',
            message: 'Cadastro realizado com sucesso',
            type: MessageType.info),
      );
    } on RestClientException catch (e, s) {
      loading.toggle();
      log('Erro ao registrar login', error: e, stackTrace: s);
      message(
        MessageModel(
          title: 'Erro',
          message: e.message,
          type: MessageType.error,
        ),
      );
    } catch (e, s) {
      loading.toggle();
      log('Erro ao registrar login', error: e, stackTrace: s);
      message(
        MessageModel(
          title: 'Erro',
          message: 'Erro ao registrar usuário',
          type: MessageType.error,
        ),
      );
    }
  }
}
