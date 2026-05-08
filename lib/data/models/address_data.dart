import 'package:flutter/foundation.dart';

/// A single saved address entry.
class AddressEntry {
  final String id;
  String label; // e.g. "Home", "Work", or custom
  String address; // human-readable location string
  bool isDefault;

  AddressEntry({
    required this.id,
    required this.label,
    required this.address,
    this.isDefault = false,
  });
}

/// Singleton that holds the list of saved addresses locally.
class AddressData extends ChangeNotifier {
  AddressData._();
  static final AddressData instance = AddressData._();

  final List<AddressEntry> _entries = [];

  List<AddressEntry> get entries => List.unmodifiable(_entries);

  AddressEntry? get defaultEntry => _entries.isEmpty
      ? null
      : _entries.firstWhere((e) => e.isDefault, orElse: () => _entries.first);

  /// Add a new address. If it's the first one, mark it default automatically.
  void add({required String label, required String address}) {
    _entries.add(
      AddressEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        label: label,
        address: address,
        isDefault: _entries.isEmpty, // first address is default
      ),
    );
    notifyListeners();
  }

  /// Remove by id.
  void remove(String id) {
    _entries.removeWhere((e) => e.id == id);
    // If we removed the default and entries remain, promote the first
    if (_entries.isNotEmpty && !_entries.any((e) => e.isDefault)) {
      _entries.first.isDefault = true;
    }
    notifyListeners();
  }

  /// Set a new default.
  void setDefault(String id) {
    for (final e in _entries) {
      e.isDefault = e.id == id;
    }
    notifyListeners();
  }
}
