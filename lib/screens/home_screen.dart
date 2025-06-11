import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/food_items.dart';
 
class Home extends StatelessWidget {
  Home({super.key});
  final List<Map<String, String>> categories = [
    {"name": "All", "image": "assets/kitfo.png"},
    {"name": "Burger", "image": "assets/bruger.png"},
    {"name": "Pizza", "image": "assets/pizza.png"},
    {"name": "Dessert", "image": "assets/kitfo.png"},
  ];
  final List<FoodItem> popularItems = [
    FoodItem(
        name: "Beef Burger",
        description: "Juicy beef burger",
        price: "20",
        imageUrl: "assets/bruger.png"),
    FoodItem(
        name: "Pizza Fries",
        description: "Cheesy pizza fries",
        price: "20",
        imageUrl: "assets/pizza.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // AppBar Row: Menu + Profile
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Menu",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/man.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Search Barkl
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.black38),
                      SizedBox(width: 10),
                      Text(
                        "search",
                        style: TextStyle(color: Colors.black38, fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Category Selector
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    padding: const EdgeInsets.all(24.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 16,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(cat["image"]!, width: 100, height: 100),
                                        const SizedBox(height: 16),
                                        Text(
                                          cat["name"]!,
                                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Short description of ${cat["name"]}",
                                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          "\$20", // Replace with actual price if available
                                          style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.add_shopping_cart),
                                          label: const Text("Add to Cart"),
                                          onPressed: () {
                                            // Add to cart logic here
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                   
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: index == 0 ? Colors.purple[100] : Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 28,
                                backgroundImage: AssetImage(cat["image"]!),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(cat["name"]!, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Promotions Section
                const Text(
                  "Promotions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B3DF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Offer",
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Free Box Of Fries",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "on off order above \$150",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image(
                          image: AssetImage('assets/kitfo.png'),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Popular Section
                const Text(
                  "Popular",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var item in popularItems)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                item.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${item.price}",
                                style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add, color: Colors.green),
                                  onPressed: () {
                                    // Add to cart logic
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
