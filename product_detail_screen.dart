import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final quantity = cart.items.containsKey(product.name)
        ? cart.items[product.name]!.quantity
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        backgroundColor: const Color(0xFFB39DDB), // 💜 lilac
        elevation: 0,
      ),

      body: Container(
        // 💜 BACKGROUND
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF3EFFF),
              Color(0xFFE6D9FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // 💜 IMAGE CARD
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.12),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  product.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 💜 NAME
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 8),

            // 💜 PRICE
            Text(
              "Rs ${product.price}",
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF7E57C2),
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 15),

            // 💜 DESCRIPTION
            Text(
              product.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6A1B9A),
              ),
            ),

            const Spacer(),

            // 💜 BUTTON AREA
            quantity == 0
                ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFFB39DDB),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(25),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  cart.addItem(
                    product.name,
                    product.name,
                    product.price,
                    product.image,
                  );
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
                : Container(
              decoration: BoxDecoration(
                color: const Color(0xFFB39DDB),
                borderRadius: BorderRadius.circular(25),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove,
                        color: Colors.white),
                    onPressed: () {
                      cart.decreaseQty(product.name);
                    },
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,
                        color: Colors.white),
                    onPressed: () {
                      cart.increaseQty(product.name);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}