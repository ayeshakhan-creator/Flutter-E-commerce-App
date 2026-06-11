import 'package:flutter/material.dart';
import 'add_product_screen.dart';
import 'login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  List<Map<String, dynamic>> products = [
    {
      "name": "Charcoal Soap",
      "price": 400,
      "image": "charcoal.jpg",
      "description": "Removes deep dirt, controls oil & detoxifies skin."
    },
    {
      "name": "Coffee Soap",
      "price": 500,
      "image": "coffee.jpg",
      "description": "Rich in antioxidants. Brightens skin & reduces spots."
    },
    {
      "name": "Rice Glow Soap",
      "price": 450,
      "image": "rice.jpg",
      "description": "Natural glow & smooth texture."
    },
    {
      "name": "Anti Acne Neem Soap",
      "price": 370,
      "image": "neem.jpg",
      "description": "Kills bacteria & fights acne."
    },
    {
      "name": "Orange Peel Soap",
      "price": 350,
      "image": "orange.jpg",
      "description": "Vitamin C boost & tan removal."
    },
    {
      "name": "2-Layered Neem & Rice Soap",
      "price": 500,
      "image": "neemrice.jpg",
      "description": "Acne control + skin brightening."
    },
    {
      "name": "2-Layered Charcoal + Multani Mitti Soap",
      "price": 480,
      "image": "charcoalmit.jpg",
      "description": "Deep cleansing + oil control."
    },
    {
      "name": "2-Layered Neem Zest Soap",
      "price": 450,
      "image": "neemzest.jpg",
      "description": "Refreshing herbal formula."
    },
    {
      "name": "2-Layered Coffee & Rice Soap",
      "price": 550,
      "image": "coffeerice.jpg",
      "description": "Exfoliation + glow combo."
    },
  ];

  void addProduct(Map<String, dynamic> newProduct) {
    setState(() {
      products.add(newProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        centerTitle: true,
        backgroundColor: const Color(0xFFB39DDB),

        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3EFFF), Color(0xFFE6D9FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [

            const Text(
              "Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 10),

            ...products.map((p) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),

                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/${p['image']}",
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),

                  title: Text(
                    p['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),

                  subtitle: Text(
                    p['description'],
                    style: const TextStyle(color: Color(0xFF7E57C2)),
                  ),

                  trailing: Text(
                    "Rs ${p['price']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            const Text(
              "Orders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "No Orders Yet",
              style: TextStyle(color: Color(0xFF7E57C2)),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB39DDB),
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductScreen(
                onAddProduct: addProduct,
              ),
            ),
          );
        },
      ),
    );
  }
}