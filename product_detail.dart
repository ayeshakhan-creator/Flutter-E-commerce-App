import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetail extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  const ProductDetail({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: Column(
        children: [
          //IMAGE FIX (assets instead of network)
          Image.asset(imageUrl, height: 200),

          Text("Rs ${price.toString()}"),

          ElevatedButton(
            onPressed: () {
              //UPDATED ADD TO CART (WITH IMAGE)
              cart.addItem(
                id,
                title,
                price,
                imageUrl,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$title added to cart 🛒"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: const Text("Add to Cart"),
          )
        ],
      ),
    );
  }
}