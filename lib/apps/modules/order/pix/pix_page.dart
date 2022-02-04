import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/formatter.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_appbar.dart';
import 'package:vakinha_burger_mobile/apps/models/order_pix.dart';

class PixPage extends StatelessWidget {
  PixPage({Key? key}) : super(key: key);

  final OrderPix _orderPix = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var qrCode = Uri.parse(_orderPix.image).data;

    return Scaffold(
      appBar: VakinhaAppbar(
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Valor a pagar', style: context.textTheme.headline4),
                Text(
                  Formatter.formatCurrency(_orderPix.value),
                  style: context.textTheme.headline4
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Image.memory(
                  qrCode!.contentAsBytes(),
                  width: context.widthTransformer(reducedBy: 50),
                  height: context.heightTransformer(reducedBy: 50),
                ),
                TextButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: _orderPix.code,
                      ),
                    );
                    Get.rawSnackbar(
                      message: 'Código copiado',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: TextButton.styleFrom(primary: Colors.grey),
                  child: Text('PIX copia e cola',
                      style: context.textTheme.headline4?.copyWith(
                        fontSize: 30,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
