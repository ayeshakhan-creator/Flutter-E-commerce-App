import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddProduct;

  const AddProductScreen({
    super.key,
    required this.onAddProduct,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();

  bool isLoading = false;

  void addProduct() {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descController.text.isEmpty ||
        imageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    double price = double.tryParse(priceController.text.trim()) ?? 0;

    if (price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid price")),
      );
      return;
    }

    final newProduct = {
      "name": nameController.text.trim(),
      "price": price,
      "description": descController.text.trim(),
      "image": imageController.text.trim(),
    };

    widget.onAddProduct(newProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product Added 💜")),
    );

    Navigator.pop(context);
  }

  InputDecoration fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF3EFFF),
      labelStyle: const TextStyle(color: Color(0xFF7E57C2)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
        backgroundColor: const Color(0xFFB39DDB),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3EFFF), Color(0xFFE6D9FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              const Icon(
                Icons.add_box,
                size: 70,
                color: Color(0xFFB39DDB),
              ),

              const SizedBox(height: 10),

              const Text(
                "Add New Product",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: fieldStyle("Name"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: fieldStyle("Price"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: descController,
                maxLines: 2,
                decoration: fieldStyle("Description"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: imageController,
                decoration: fieldStyle("Image (e.g: coffee.jpg)"),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: addProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB39DDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("ADD PRODUCT"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}