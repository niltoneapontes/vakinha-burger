import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/formatter.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/vakinha_ui.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/plus_minus_box.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_button.dart';
import 'package:validatorless/validatorless.dart';
import './shopping_cart_controller.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  final formKey = GlobalKey<FormState>();

  ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Visibility(
                      visible: controller.products.isNotEmpty,
                      replacement: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_shopping_cart_rounded,
                              color: Colors.grey,
                              size: 80,
                            ),
                            Text(
                              'Você ainda não adicionou nada ao carrinho.',
                              style: VakinhaUi.textBold.copyWith(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Carrinho',
                                style: context.textTheme.headline6?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.theme.primaryColorDark,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => controller.clear(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return Column(
                              children: controller.products
                                  .map(
                                    (p) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: PlusMinusBox(
                                        quantity: p.quantity,
                                        price: p.product.price * p.quantity,
                                        label: p.product.name,
                                        minusCallback: () =>
                                            controller.addQuantityInProduct(p),
                                        plusCallback: () =>
                                            controller.addQuantityInProduct(p),
                                        backgroundColor: Colors.white,
                                        elevated: true,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total do pedido: ',
                                style: context.textTheme.bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Obx(() {
                                return Text(
                                  Formatter.formatCurrency(
                                      controller.totalValue),
                                  style: context.textTheme.headline6
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                );
                              }),
                            ],
                          ),
                          const Divider(),
                          const _AddressField(),
                          const Divider(),
                          const _CpfField(),
                          const Divider(),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: context.widthTransformer(reducedBy: 10),
                            child: VakinhaButton(
                                onPressed: () {
                                  final formValid =
                                      formKey.currentState?.validate() ?? false;
                                  if (formValid) {
                                    controller.createOrder();
                                  }
                                },
                                label: 'FINALIZAR'),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}

class _AddressField extends GetView<ShoppingCartController> {
  const _AddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
          child: Expanded(
            child: Text('Endereço de entrega',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18)),
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            controller.address = value;
          },
          validator: Validatorless.required('Endereço obrigatório'),
          decoration: const InputDecoration(
            hintText: 'Digite o endereço',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}

class _CpfField extends GetView<ShoppingCartController> {
  const _CpfField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
          child: Expanded(
            child: Text('CPF',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18)),
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            controller.cpf = value;
          },
          validator: Validatorless.required('CPF é obrigatório'),
          decoration: const InputDecoration(
            hintText: 'Digite o CPF',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
