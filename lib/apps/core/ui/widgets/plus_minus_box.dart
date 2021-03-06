import 'package:flutter/material.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/formatter.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/ui/widgets/vakinha_rounded_button.dart';

class PlusMinusBox extends StatelessWidget {
  final bool elevated;
  final Color? backgroundColor;
  final String? label;
  final int quantity;
  final double price;
  final VoidCallback minusCallback;
  final VoidCallback plusCallback;

  const PlusMinusBox(
      {Key? key,
      this.elevated = false,
      this.backgroundColor,
      this.label,
      required this.quantity,
      required this.price,
      required this.minusCallback,
      required this.plusCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevated ? 5 : 0,
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.black26,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints:
            BoxConstraints(maxWidth: context.widthTransformer(reducedBy: 10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: label != null,
              child: Text(
                label ?? '',
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                VakinhaRoundedButton(onPressed: minusCallback, label: '-'),
                Text('$quantity'),
                VakinhaRoundedButton(onPressed: plusCallback, label: '+'),
              ],
            ),
            Visibility(
              visible: label == null,
              child: const Spacer(),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 10),
              constraints: const BoxConstraints(minWidth: 70),
              child: Text(
                Formatter.formatCurrency(price),
              ),
            )
          ],
        ),
      ),
    );
  }
}
