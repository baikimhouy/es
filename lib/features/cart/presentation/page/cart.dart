import 'package:flutter/material.dart';
import '../widgets/cart_widget.dart';
import '../../../../core/router/app_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartPageState();
}

class _CartPageState extends State<CartScreen> {
  int currentIndex = 1;

  List<Map<String, dynamic>> items = [
    {
      'name': 'Blush',
      'price': 18.7,
      'oldPrice': 70.0,
      'qty': 1,
      'selected': true,
      'image': 'assets/images/option2.png',
    },
    {
      'name': 'Sunscreen',
      'price': 10.0,
      'oldPrice': 70.0,
      'qty': 1,
      'selected': true,
      'image': 'assets/images/product_gallery_2.png',
    },
  ];

  /// ✅ TOTAL (ONLY SELECTED)
  double get total {
    double sum = 0;
    for (var item in items) {
      if (item['selected'] == true) {
        sum += (item['price'] ?? 0) * (item['qty'] ?? 1);
      }
    }
    return sum;
  }

  /// ✅ SELECT COUNT
  int get selectedCount => items.where((e) => e['selected'] == true).length;

  /// ✅ CHECK ALL
  bool get isAllSelected => items.every((e) => e['selected'] == true);

  bool get hasSelectedItems => selectedCount > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Cart", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ================= SELECT ALL =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Checkbox(
                    value: isAllSelected,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        for (var item in items) {
                          item['selected'] = value ?? false;
                        }
                      });
                    },
                  ),
                  const Text("Select all"),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      setState(() {
                        items.removeWhere((e) => e['selected'] == true);
                      });
                    },
                  ),
                ],
              ),
            ),

            // ================= LIST =================
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return CartItemCard(
                    title: item['name'],
                    price: item['price'],
                    oldPrice: item['oldPrice'],
                    quantity: item['qty'],
                    isSelected: item['selected'],
                    imagePath: item['image'],

                    onIncrement: () {
                      setState(() => item['qty']++);
                    },

                    onDecrement: () {
                      setState(() {
                        if (item['qty'] > 1) item['qty']--;
                      });
                    },

                    onToggleSelect: (value) {
                      setState(() {
                        item['selected'] = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),

            // ================= FIXED BOTTOM BAR =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: hasSelectedItems
                          ? () {
                              final selectedItems = items
                                  .asMap()
                                  .entries
                                  .where((e) => e.value['selected'])
                                  .map(
                                    (e) => {
                                      'name': e.value['name'],
                                      'price': e.value['price'],
                                      'qty': e.value['qty'],
                                      'image': e.value['image'],
                                    },
                                  )
                                  .toList();

                              Navigator.pushNamed(
                                context,
                                AppRouter.payment,
                                arguments: selectedItems,
                              );
                            }
                          : null,
                      child: Container(
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: hasSelectedItems
                              ? Colors.pink
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          "Place order ($selectedCount)",
                          style: TextStyle(
                            color: hasSelectedItems
                                ? Colors.white
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Total", style: TextStyle(color: Colors.grey)),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
