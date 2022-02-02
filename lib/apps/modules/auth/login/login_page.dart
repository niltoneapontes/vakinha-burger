import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/vakinha_state.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/vakinha_ui.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_appbar.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_button.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_textformfield.dart';
import 'package:vakinha_burger_mobile/apps/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends VakinhaState<LoginPage, LoginController> {
  final formKey = GlobalKey<FormState>();

  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppbar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: context.textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.theme.primaryColorDark,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          VakinhaTextformfield(
                            label: 'E-mail',
                            controller: emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail é obrigatório'),
                              Validatorless.email('E-mail inválido')
                            ]),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          VakinhaTextformfield(
                            label: 'Senha',
                            obscureText: true,
                            controller: passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha é obrigatória'),
                              Validatorless.min(6, 'Senha inválida')
                            ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: VakinhaButton(
                              width: context.width,
                              onPressed: () {
                                final formValid =
                                    formKey.currentState?.validate() ?? false;

                                if (formValid) {
                                  controller.login(
                                    email: emailEC.text,
                                    password: passwordEC.text,
                                  );
                                }
                              },
                              label: 'ENTRAR',
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não possui uma conta?'),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/auth/register');
                                },
                                child: const Text(
                                  'Cadastre-se',
                                  style: VakinhaUi.textBold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
