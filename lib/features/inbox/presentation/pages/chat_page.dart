// lib/features/inbox/presentation/pages/chat_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';

// ── Message model ─────────────────────────────────────────────────────────
enum _MsgType { text, image }

class _Message {
  final String text;
  final _MsgType type;
  final bool isMe;
  final DateTime time;
  final String? imagePath;

  const _Message({
    this.text = '',
    this.type = _MsgType.text,
    required this.isMe,
    required this.time,
    this.imagePath,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// CHAT PAGE
// ═══════════════════════════════════════════════════════════════════════════
class ChatPage extends StatefulWidget {
  final String contactId;
  final String contactName;
  final String contactSubtitle;
  final String avatarEmoji;
  final Color avatarBg;

  const ChatPage({
    super.key,
    required this.contactId,
    required this.contactName,
    required this.contactSubtitle,
    required this.avatarEmoji,
    required this.avatarBg,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _picker = ImagePicker();

  late final List<_Message> _messages = [
    _Message(
      text: 'Hello! How can we help you today? 😊',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    _Message(
      text: 'Hi! I have a question about my order.',
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    _Message(
      text:
          'Sure! Please share your order ID and we will look into it right away.',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
  ];

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendText() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text: text, isMe: true, time: DateTime.now()));
      _textCtrl.clear();
    });
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 1), _simulateReply);
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;
    setState(() {
      _messages.add(
        _Message(
          type: _MsgType.image,
          isMe: true,
          time: DateTime.now(),
          imagePath: picked.path,
        ),
      );
    });
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 1), _simulateReply);
  }

  Future<void> _pickCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked == null || !mounted) return;
    setState(() {
      _messages.add(
        _Message(
          type: _MsgType.image,
          isMe: true,
          time: DateTime.now(),
          imagePath: picked.path,
        ),
      );
    });
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 1), _simulateReply);
  }

  void _simulateReply() {
    if (!mounted) return;
    const replies = [
      'Got it! We will check that for you. 🌸',
      'Thank you for reaching out!',
      'Is there anything else we can help with?',
      'We appreciate your patience 💕',
    ];
    setState(() {
      _messages.add(
        _Message(
          text: replies[DateTime.now().second % replies.length],
          isMe: false,
          time: DateTime.now(),
        ),
      );
    });
    _scrollToBottom();
  }

  String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  // ── SVG avatar (used in AppBar + bubbles) ─────────────────────────────
  Widget _svgAvatar({required double size, double padding = 8}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFFF79A2), Color(0xFFFFAEC7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Image.asset('assets/images/eternal2.png', fit: BoxFit.contain),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            // ── SVG avatar in AppBar ──────────────────────────────
            _svgAvatar(size: 38, padding: 7),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.contactName,
                    style: tt.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.contactSubtitle,
                    style: tt.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.call_outlined,
              color: AppColors.primary,
              size: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.textSecondary,
              size: 22,
            ),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _buildBubble(_messages[i], tt),
            ),
          ),
          _InputBar(
            controller: _textCtrl,
            onSend: _sendText,
            onPickImage: _pickImage,
            onPickCamera: _pickCamera,
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(_Message msg, TextTheme tt) {
    final isMe = msg.isMe;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── SVG avatar beside incoming bubbles ──────────────────
          if (!isMe) ...[
            _svgAvatar(size: 28, padding: 5),
            const SizedBox(width: 8),
          ],

          // ── Bubble ──────────────────────────────────────────────
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.68,
                  ),
                  padding: msg.type == _MsgType.image
                      ? const EdgeInsets.all(4)
                      : const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isMe ? 18 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 18),
                    ),
                    border: isMe ? null : Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.border,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: msg.type == _MsgType.image && msg.imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(
                            File(msg.imagePath!),
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          msg.text,
                          style: tt.bodyMedium?.copyWith(
                            color: isMe
                                ? AppColors.surface
                                : AppColors.textPrimary,
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                ),
                const SizedBox(height: 3),
                Text(
                  _formatTime(msg.time),
                  style: tt.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          if (isMe) const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// INPUT BAR
// ═══════════════════════════════════════════════════════════════════════════
class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onPickImage;
  final VoidCallback onPickCamera;

  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.onPickImage,
    required this.onPickCamera,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8 + bottomPad),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          _IconBtn(icon: Icons.camera_alt_outlined, onTap: onPickCamera),
          const SizedBox(width: 4),
          _IconBtn(icon: Icons.image_outlined, onTap: onPickImage),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                style: tt.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: tt.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => onSend(),
                textInputAction: TextInputAction.send,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: AppColors.surface,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.divider,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}
