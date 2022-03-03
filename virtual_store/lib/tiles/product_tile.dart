import 'package:flutter/material.dart';

import '../datas/product_data.dart';
import '../screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.type, this.data, {Key? key}) : super(key: key);

  final String type;
  final ProductData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(data))
        );
      },
      child: Card(
        child: type == "grid"
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                data.images![0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      data.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "R\$ ${data.price?.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
            : Row(
          children: [
            Flexible(
              flex: 1,
              child: Image.network(
                data.images![0],
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "R\$ ${data.price?.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
