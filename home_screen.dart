import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'customize_soap_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final ScrollController scrollController = ScrollController();

    //PRODUCT LIST
    List<Product> products = [
      Product(
        name: "Charcoal Soap",
        price: 400,
        image: "assets/images/charcoal.jpg",
        description:
        "Removes deep dirt, controls oil & detoxifies skin. Best for acne-prone skin.",
      ),
      Product(
        name: "Coffee Soap",
        price: 500,
        image: "assets/images/coffee.jpg",
        description:
        "Rich in antioxidants. Helps brighten skin & reduce dark spots.",
      ),
      Product(
        name: "Rice Glow Soap",
        price: 450,
        image: "assets/images/rice.jpg",
        description:
        "Gives natural glow, smooth texture & improves skin tone.",
      ),
      Product(
        name: "Anti Acne Neem Soap",
        price: 370,
        image: "assets/images/neem.jpg",
        description:
        "Kills bacteria, fights acne & soothes irritated skin.",
      ),
      Product(
        name: "Orange Peel Soap",
        price: 350,
        image: "assets/images/orange.jpg",
        description:
        "Vitamin C boost for glowing skin & tan removal.",
      ),
      Product(
        name: "2-Layered Neem & Rice Soap",
        price: 500,
        image: "assets/images/neemrice.jpg",
        description:
        "Dual benefits of acne control + skin brightening.",
      ),
      Product(
        name: "2-Layered Charcoal + Multani Mitti Soap",
        price: 480,
        image: "assets/images/charcoalmit.jpg",
        description:
        "Deep cleansing + oil control for fresh & clean skin.",
      ),
      Product(
        name: "2-Layered Neem Zest Soap",
        price: 450,
        image: "assets/images/neemzest.jpg",
        description:
        "Refreshing herbal formula for glowing & healthy skin.",
      ),
      Product(
        name: "2-Layered Coffee & Rice Soap",
        price: 550,
        image: "assets/images/coffeerice.jpg",
        description:
        "Exfoliation + glow combo for soft radiant skin.",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Remed Aura"),
        centerTitle: true,
        backgroundColor: const Color(0xFFB39DDB), // 💜 Lilac

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          },
        ),

        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CartScreen()),
                  );
                },
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF7E57C2), // 💜 darker lilac badge
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.itemCount.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10),
                    ),
                  ),
                )
            ],
          )
        ],
      ),

      body: Container(
        // 💜 LIGHT LILAC BACKGROUND
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            thickness: 6,
            radius: const Radius.circular(10),
            child: GridView.builder(
              controller: scrollController,
              itemCount: products.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  product: product,
                  onAddToCart: () {
                    final cartProvider =
                    Provider.of<CartProvider>(context, listen: false);

                    cartProvider.addItem(
                      product.name,
                      product.name,
                      product.price,
                      product.image,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                        const Color(0xFFB39DDB), // 💜 lilac snackbar
                        content: Text(
                          "${product.name} added to cart 🛒",
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB39DDB),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomizeSoapScreen(),
            ),
          );
        },
        child: const Icon(Icons.brush),
      ),
    );
  }
}