import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/models/profile_data.dart';
import '../widgets/profile_avatar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  String? _selectedGender;
  DateTime? _selectedDate;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final _picker = ImagePicker();

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    final p = ProfileData.instance;
    _firstNameController = TextEditingController(text: p.firstName);
    _lastNameController = TextEditingController(text: p.lastName);
    _phoneController = TextEditingController(text: p.phone);
    _selectedGender = p.gender.isEmpty ? null : p.gender;
    _selectedDate = _parseBirthday(p.birthday);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  DateTime? _parseBirthday(String text) {
    try {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final parts = text.split(' ');
      if (parts.length < 3) return null;
      return DateTime(
        int.parse(parts[2]),
        months.indexOf(parts[1]) + 1,
        int.parse(parts[0]),
      );
    } catch (_) {
      return null;
    }
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]} ${dt.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFFF79A2),
            onPrimary: Colors.white,
            onSurface: Color(0xFF2B2B2B),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  /// Pick an image from the gallery and save bytes into [ProfileData].
  Future<void> _pickAvatar() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    ProfileData.instance.update(
      avatarBytes: bytes,
    ); // notifies listeners immediately
  }

  void _saveProfile() {
    ProfileData.instance.update(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phone: _phoneController.text.trim(),
      gender: _selectedGender ?? '',
      birthday: _selectedDate != null
          ? _formatDate(_selectedDate!)
          : ProfileData.instance.birthday,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated!'),
        backgroundColor: Color(0xFFFF79A2),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFCFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFFFF79A2),
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2B2B2B),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── Avatar with edit badge — tapping opens gallery ─────────
            Center(
              child: ProfileAvatar(
                size: 80,
                showEditBadge: true,
                onEditTap: _pickAvatar,
              ),
            ),

            const SizedBox(height: 12),

            // Live name & email from singleton
            ListenableBuilder(
              listenable: ProfileData.instance,
              builder: (_, _) => Column(
                children: [
                  Text(
                    ProfileData.instance.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2B2B2B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ProfileData.instance.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7D7D7D),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            _buildTextField(
              controller: _firstNameController,
              hint: 'First Name',
            ),
            const SizedBox(height: 16),
            _buildTextField(controller: _lastNameController, hint: 'Last Name'),
            const SizedBox(height: 16),
            _buildDropdown(),
            const SizedBox(height: 16),
            _buildPhoneField(),
            const SizedBox(height: 16),

            // Birthday
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE9DCE1))),
                ),
                child: Text(
                  _selectedDate != null
                      ? _formatDate(_selectedDate!)
                      : 'Date of birth',
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedDate != null
                        ? const Color(0xFF2B2B2B)
                        : const Color(0xFF7D7D7D),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF79A2),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ── Field helpers ─────────────────────────────────────────────────────────

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14, color: Color(0xFF2B2B2B)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF7D7D7D)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE9DCE1)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFF79A2)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedGender,
      hint: const Text(
        'Select your gender',
        style: TextStyle(fontSize: 14, color: Color(0xFF7D7D7D)),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF7D7D7D)),
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE9DCE1)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFF79A2)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
      items: _genders
          .map(
            (g) => DropdownMenuItem(
              value: g,
              child: Text(g, style: const TextStyle(fontSize: 14)),
            ),
          )
          .toList(),
      onChanged: (val) => setState(() => _selectedGender = val),
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE9DCE1))),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            child: Text('🇰🇭', style: TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(fontSize: 14, color: Color(0xFF2B2B2B)),
            decoration: const InputDecoration(
              hintText: 'Phone number',
              hintStyle: TextStyle(fontSize: 14, color: Color(0xFF7D7D7D)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE9DCE1)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF79A2)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
