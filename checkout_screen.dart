import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../services/firestore_service.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}
class _CheckoutScreenState extends State<CheckoutScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final firestore = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
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

        child: SingleChildScrollView(
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
              children: [

                // 💜 ICON
                const Icon(
                  Icons.payment,
                  size: 70,
                  color: Color(0xFFB39DDB),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Enter Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                  ),
                ),

                const SizedBox(height: 20),

                // 💜 NAME FIELD
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person,
                        color: Color(0xFF9575CD)),
                    hintText: "Full Name",
                    filled: true,
                    fillColor: const Color(0xFFF3EFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 💜 ADDRESS FIELD
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on,
                        color: Color(0xFF9575CD)),
                    hintText: "Address",
                    filled: true,
                    fillColor: const Color(0xFFF3EFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 💜 PHONE FIELD
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone,
                        color: Color(0xFF9575CD)),
                    hintText: "Phone Number",
                    filled: true,
                    fillColor: const Color(0xFFF3EFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 💜 TOTAL
                Text(
                  "Total: Rs ${cart.totalAmount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A148C),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Payment Method: Cash on Delivery (COD)",
                  style: TextStyle(color: Color(0xFF7E57C2)),
                ),

                const SizedBox(height: 25),

                // 💜 BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                      if (nameController.text.isEmpty ||
                          addressController.text.isEmpty ||
                          phoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                            Text("Please fill all fields"),
                          ),
                        );
                        return;
                      }

                      setState(() => isLoading = true);

                      double totalAmount = cart.totalAmount;

                      try {
                        await firestore
                            .placeOrder({
                          "name": nameController.text,
                          "address":
                          addressController.text,
                          "phone":
                          phoneController.text,
                          "total": totalAmount,
                          "payment": "COD",
                          "date": DateTime.now()
                              .toIso8601String(),
                        })
                            .timeout(
                            const Duration(seconds: 5));
                      } catch (e) {
                        debugPrint("Firestore Error: $e");
                      }

                      cart.clearCart();

                      if (!context.mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const OrderSuccessScreen(),
                        ),
                      );

                      setState(() => isLoading = false);
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
                    child: isLoading
                        ? const CircularProgressIndicator(
                        color: Colors.white)
                        : const Text(
                      "Confirm Order",
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