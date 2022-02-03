import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/formatter.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/vakinha_ui.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_appbar.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_button.dart';
import './product_detail_controller.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppbar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.width,
                    height: context.heightTransformer(reducedBy: 60),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://s2.glbimg.com/-on4mnFlw5G3RI4sFYUyPcsE5lE=/620x466/e.glbimg.com/og/ed/f/original/2021/05/26/burger_nou.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('X-TUDAO',
                        style: context.textTheme.headline4!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'X-TUDAO',
                      style: context.textTheme.bodyText2!,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Componente de botão'),
                  const Divider(),
                  ListTile(
                    title: const Text("Total", style: VakinhaUi.textBold),
                    trailing: Text(
                      Formatter.formatCurrency(200),
                      style: VakinhaUi.textBold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: SizedBox(
                          child: VakinhaButton(
                              onPressed: () {}, label: 'ADICIONAR')))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
