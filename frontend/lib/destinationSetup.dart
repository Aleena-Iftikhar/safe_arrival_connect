import 'package:flutter/material.dart';
import 'commonWidget/bottomNavigationBar.dart';


class SetupJourneyPage extends StatefulWidget {
  const SetupJourneyPage({super.key});

  @override
  State<SetupJourneyPage> createState() => _SetupJourneyPageState();
}

class _SetupJourneyPageState extends State<SetupJourneyPage> {
  int _selectedIndex = 1;

  final TextEditingController _destinationNameController =
  TextEditingController();
  final TextEditingController _destinationAddressController =
  TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Contacts list with selection state
  final List<Map<String, dynamic>> _contacts = [
    {'initial': 'M', 'name': 'Mom', 'number': '+92 300 1234567', 'selected': false},
    {'initial': 'D', 'name': 'Dad', 'number': '+92 300 7654321', 'selected': false},
    {'initial': 'A', 'name': 'Ayesha', 'number': '+92 321 9988776', 'selected': false},
    {'initial': 'E', 'name': 'Emergency Hotline', 'number': '+92 300 0000115', 'selected': false},
  ];

  static const Color _primary = Color(0xFF5B8DEF);
  static const Color _bgPage = Color(0xFFF8F9FA);
  static const Color _textPrimary = Color(0xFF1C1C1E);
  static const Color _textSecondary = Color(0xFF8E8E93);
  static const Color _borderColor = Color(0xFFE5E5EA);

  @override
  void dispose() {
    _destinationNameController.dispose();
    _destinationAddressController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgPage,

      bottomNavigationBar: BottomNav(
      selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/setup');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/contacts');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/history');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/settings');
              break;
          }
        },
    ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Page Title ──
              const Text(
                'Setup Journey',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Configure your destination and message',
                style: TextStyle(fontSize: 18, color: _textSecondary),
              ),

              const SizedBox(height: 28),

              // ── Destination Name ──
              _sectionLabel('Destination Name'),
              const SizedBox(height: 8),
              _inputField(
                controller: _destinationNameController,
                hint: 'Enter your destination..',
              ),

              const SizedBox(height: 20),

              // ── Destination Address ──
              _sectionLabel('Destination Address'),
              const SizedBox(height: 8),
              _inputField(
                controller: _destinationAddressController,
                hint: 'Enter address',
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  color: _textSecondary,
                  size: 18,
                ),
              ),
              const SizedBox(height: 10),

              // ── Use Current Location ──
              GestureDetector(
                onTap: () {
                  // TODO: get current GPS location
                },
                child: Row(
                  children: const [
                    Icon(Icons.near_me_outlined, color: _primary, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Use current location',
                      style: TextStyle(
                        color: _primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Map Placeholder ──
              GestureDetector(
                onTap: () {
                  // TODO: open map picker
                },
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDEEAFD),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFB8D0F8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: _primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tap to pin location on map',
                        style: TextStyle(
                          color: _primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Arrival Message ──
              _sectionLabel('Arrival Message'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _borderColor),
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 16,
                    color: _textPrimary,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    border: InputBorder.none,
                    hintText: 'Type your arrival message...',
                    hintStyle: TextStyle(color: _textSecondary),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── Recipients ──
              _sectionLabel('Recipients'),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  children: List.generate(_contacts.length, (index) {
                    final contact = _contacts[index];
                    final isLast = index == _contacts.length - 1;
                    return Column(
                      children: [
                        _contactTile(contact, index),
                        if (!isLast)
                          Divider(
                            height: 1,
                            color: _borderColor,
                            indent: 68,
                          ),
                      ],
                    );
                  }),
                ),
              ),

              const SizedBox(height: 28),

              // ── Save Journey Button ──
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Selected contacts
                    final selectedContacts = _contacts
                        .where((c) => c['selected'] == true)
                        .toList();

                    // navigate result back to home screen
                    Navigator.pop(context, {
                      'destinationName': _destinationNameController.text.trim(),
                      'destinationAddress':
                      _destinationAddressController.text.trim(),
                      'message': _messageController.text.trim(),
                      'contacts': selectedContacts,
                    });
                  },
                  icon: const Icon(Icons.save_outlined, size: 22),
                  label: const Text(
                    'Save Journey',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ── Contact Tile ──
  Widget _contactTile(Map<String, dynamic> contact, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar circle
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFEBF2FE),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                contact['initial'],
                style: const TextStyle(
                  color: Color(0xFF5B8DEF),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Name & number
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  contact['number'],
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
          // Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                _contacts[index]['selected'] = !_contacts[index]['selected'];
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: contact['selected']
                    ? const Color(0xFF5B8DEF)
                    : Colors.transparent,
                border: Border.all(
                  color: contact['selected']
                      ? const Color(0xFF5B8DEF)
                      : const Color(0xFFD1D1D6),
                  width: 2,
                ),
              ),
              child: contact['selected']
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // ── Input Field Helper ──
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    Widget? prefixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5EA)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 15, color: Color(0xFF1C1C1E)),
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  // ── Section Label Helper ──
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}