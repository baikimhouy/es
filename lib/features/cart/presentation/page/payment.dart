import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. DATA HANDLING: Get data from the previous screen (Cart List)
    final raw = ModalRoute.of(context)?.settings.arguments;
    final items = raw != null
        ? List<Map<String, dynamic>>.from(raw as List)
        : [];

    // Keep order consistent based on index
    items.sort((a, b) => (a['index'] ?? 0).compareTo(b['index'] ?? 0));

    // 2. CALCULATIONS
    double subtotal = 0;
    for (var item in items) {
      subtotal += (item['price'] ?? 0) * (item['qty'] ?? 1);
    }

    double discount = 6.20;
    double birthdayDiscount = 0.00;
    double memberDiscount = 0.00;
    double deliveryFee = 1.00;
    double total =
        subtotal - discount - birthdayDiscount - memberDiscount + deliveryFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Subtle off-white background
      // --- APP BAR ---
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context), // 🟢 Back to cart_list
        ),
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey, height: 1),
        ),
      ),

      // --- BODY ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120), // Space for fixed button
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// 🔴 DELIVERY TOGGLE (PILL SHAPE)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFC7CACE),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF2D6C), // Exact Brand Pink
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Delivery",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Pick Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// INFO TILES (Clean thin borders)
            _buildActionTile(Icons.map_outlined, "Address"),
            _buildActionTile(Icons.local_shipping_outlined, "Delivery Method"),
            _buildActionTile(Icons.assignment_outlined, "Apply Voucher"),

            /// NOTE BOX
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Note",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4A61A8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter note",
                      hintStyle: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Order Summary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            /// DYNAMIC ITEMS LIST
            ...items.map((item) => _buildItemCard(item)),

            const SizedBox(height: 20),

            /// PAYMENT DETAILS SECTION
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "PAYMENT DETAILS",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),

            _buildPaymentSummary(
              subtotal,
              discount,
              birthdayDiscount,
              memberDiscount,
              deliveryFee,
              total,
            ),

            /// ABA KHQR TILE
            _buildABATile(),
          ],
        ),
      ),

      // --- STICKY BOTTOM BUTTON ---
      bottomSheet: _buildPayButton(),
    );
  }

  /// HELPER: Action Tiles (Address, Voucher, etc)
  Widget _buildActionTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 0.8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87, size: 22),
          const SizedBox(width: 15),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  /// HELPER: Item Card (Matching Image Layout)
  Widget _buildItemCard(Map item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 0.8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              item['image'] ?? '',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: Colors.pink[50],
                width: 70,
                height: 70,
                child: const Icon(Icons.image, color: Colors.pink),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const Text(
                  "Creates vivid face with gorgeous co...",
                  maxLines: 1,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  "\$${(item['price'] ?? 0).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xFFFF2D6C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "x${item['qty'] ?? 1}",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// HELPER: Payment Detail List
  Widget _buildPaymentSummary(
    double sub,
    double disc,
    double birth,
    double mem,
    double del,
    double total,
  ) {
    Widget row(
      String label,
      String value, {
      Color? valColor,
      bool isBold = false,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isBold ? Colors.black : Colors.black87,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valColor ?? Colors.black87,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          row("Sub total", "\$ ${sub.toStringAsFixed(2)}"),
          row(
            "Discount",
            "-\$ ${disc.toStringAsFixed(2)}",
            valColor: const Color(0xFFFF8B94),
          ),
          row(
            "Birthday Discount",
            "-\$ ${birth.toStringAsFixed(2)}",
            valColor: Colors.lightGreen,
          ),
          row("Member Discount(0.0%)", "-\$ ${mem.toStringAsFixed(2)}"),
          row("Delivery Fee", "\$ ${del.toStringAsFixed(0)}"),
          const Divider(height: 30, thickness: 1),
          row("TOTAL", "\$ ${total.toStringAsFixed(2)}", isBold: true),
        ],
      ),
    );
  }

  /// HELPER: ABA Payment Row
  Widget _buildABATile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFD0001D),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "KHQR",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ABA KHQR",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "Scan to pay with any banking app",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  /// HELPER: Bottom "PAY NOW" Button
  Widget _buildPayButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Logic for processing payment
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF2D6C),
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: const Text(
          "PAY NOW",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
