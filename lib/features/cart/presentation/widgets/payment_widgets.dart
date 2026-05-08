import 'package:flutter/material.dart';

class DeliveryToggle extends StatelessWidget {
  const DeliveryToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.pink,
            child: const Center(
              child: Text("Delivery", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey,
            child: const Center(child: Text("Pick Up")),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int qty;
  final String image;

  const OrderItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.qty,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$${price.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.pink),
            ),
            Text("x$qty"),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailsDynamic extends StatelessWidget {
  final double subtotal;

  const PaymentDetailsDynamic({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    double delivery = 1;
    double total = subtotal + delivery;

    Widget row(String t, String v) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(t), Text(v)],
        ),
      );
    }

    return Column(
      children: [
        row("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
        row("Delivery", "\$${delivery.toStringAsFixed(2)}"),
        const Divider(),
        row("TOTAL", "\$${total.toStringAsFixed(2)}"),
      ],
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {},
        child: const Text("PAY NOW"),
      ),
    );
  }
}
