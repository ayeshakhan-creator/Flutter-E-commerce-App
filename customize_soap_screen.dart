import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CustomizeSoapScreen extends StatefulWidget {
  const CustomizeSoapScreen({super.key});

  @override
  State<CustomizeSoapScreen> createState() =>
      _CustomizeSoapScreenState();
}

class _CustomizeSoapScreenState extends State<CustomizeSoapScreen> {
  String layer1 = "Charcoal";
  String layer2 = "Coffee";

  final List<String> options = [
    "Charcoal",
    "Coffee",
    "Rice",
    "Neem",
    "Orange Peel"
  ];

  final double price = 600;
  final String customImage = "assets/images/custom.jpg";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Your Own Soap"),
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

        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),

            // 💜 CARD
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                )
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // 💜 ICON
                const Icon(
                  Icons.brush,
                  size: 65,
                  color: Color(0xFFB39DDB),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Create Your Own Soap",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                  ),
                ),

                const SizedBox(height: 25),

                // 💜 LAYER 1 DROPDOWN
                DropdownButtonFormField<String>(
                  value: layer1,
                  decoration: InputDecoration(
                    labelText: "Select Layer 1",
                    filled: true,
                    fillColor: const Color(0xFFF3EFFF),
                    labelStyle:
                    const TextStyle(color: Color(0xFF7E57C2)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: Colors.white,
                  items: options
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (v) {
                    setState(() => layer1 = v!);
                  },
                ),

                const SizedBox(height: 20),

                // 💜 LAYER 2 DROPDOWN
                DropdownButtonFormField<String>(
                  value: layer2,
                  decoration: InputDecoration(
                    labelText: "Select Layer 2",
                    filled: true,
                    fillColor: const Color(0xFFF3EFFF),
                    labelStyle:
                    const TextStyle(color: Color(0xFF7E57C2)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: Colors.white,
                  items: options
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (v) {
                    setState(() => layer2 = v!);
                  },
                ),

                const SizedBox(height: 30),

                // 💜 BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final productId =
                          "soap_${layer1}_$layer2";

                      cart.addItem(
                        productId,
                        "Custom Soap ($layer1 + $layer2)",
                        price,
                        customImage,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                          const Color(0xFFB39DDB),
                          content: Text(
                            "Added to Cart: $layer1 + $layer2 🧼",
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFFB39DDB), // 💜 lilac
                      padding: const EdgeInsets.symmetric(
                          vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Add to Cart (Rs 600)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}