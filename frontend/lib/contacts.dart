import 'package:flutter/material.dart';

import 'commonWidget/bottomNavigationBar.dart';

// ─────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────

class Contact {
  final String name;
  final String phone;
  final String category; // 'Family', 'Friends', 'Emergency'

  const Contact({
    required this.name,
    required this.phone,
    required this.category,
  });
}

// ─────────────────────────────────────────────
//  CONTACTS PAGE
// ─────────────────────────────────────────────

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String _selectedFilter = 'All';
  int _selectedIndex = 2;

  final List<String> _filters = ['All', 'Family', 'Friends', 'Emergency'];

  final List<Contact> _contacts = [
    const Contact(name: 'Mom',               phone: '+92 300 1234567', category: 'Family'),
    const Contact(name: 'Dad',               phone: '+92 300 7654321', category: 'Family'),
    const Contact(name: 'Ayesha',            phone: '+92 321 9988776', category: 'Friends'),
    const Contact(name: 'Emergency Hotline', phone: '+92 300 0000115', category: 'Emergency'),
  ];

  // ── Avatar color per first letter ───────────────────
  Color _avatarColor(String name) {
    final colors = {
      'M': const Color(0xFFD0D8F5),
      'D': const Color(0xFFD5D0F5),
      'A': const Color(0xFFD0F0E8),
      'E': const Color(0xFFF5D5D0),
    };
    return colors[name[0].toUpperCase()] ?? const Color(0xFFE8EAF6);
  }

  Color _avatarTextColor(String name) {
    final colors = {
      'M': const Color(0xFF5B6FD4),
      'D': const Color(0xFF7B6FD4),
      'A': const Color(0xFF3BAD85),
      'E': const Color(0xFFD45B5B),
    };
    return colors[name[0].toUpperCase()] ?? const Color(0xFF5B6FD4);
  }

  // ── Filtered list ───────────────────────────────────────────────────────────
  List<Contact> get _filteredContacts {
    if (_selectedFilter == 'All') return _contacts;
    return _contacts.where((c) => c.category == _selectedFilter).toList();
  }

  // ── Delete contact ──────────────────────────────────────────────────────────
  void _deleteContact(Contact contact) {
    setState(() => _contacts.remove(contact));
  }

  // ── Add contact dialog ──────────────────────────────────────────────────────
  void _showAddContactDialog() {
    final nameController  = TextEditingController();
    final phoneController = TextEditingController();
    String selectedCategory = 'Family';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Add Contact',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                items: ['Family', 'Friends', 'Emergency', 'Work', 'Others']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) =>
                    setDialogState(() => selectedCategory = val!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.black45, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B6FD4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  setState(() {
                    _contacts.add(Contact(
                      name:     nameController.text.trim(),
                      phone:    phoneController.text.trim(),
                      category: selectedCategory,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredContacts;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      // ── APP BAR ──────────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        titleSpacing: 24,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contacts',
              style: TextStyle(
                color: Color(0xFF1A1D2E),
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '${_contacts.length} saved',
              style: const TextStyle(
                color: Color(0xFF8A90A8),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: _showAddContactDialog,
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFF5B6FD4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add,
                    color: Colors.white, size: 26),
              ),
            ),
          ),
        ],
      ),

      // ── BODY ─────────────────────────────────────────────────────────────────
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── FILTER CHIPS ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedFilter = filter),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 9),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF5B6FD4)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF5B6FD4)
                                : const Color(0xFFE8EAF0),
                          ),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF414655),
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // ── CONTACT LIST ────────────────────────────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? const Center(
              child: Text(
                'No contacts found',
                style: TextStyle(
                    color: Color(0xFF9098B3), fontSize: 20),
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: filtered.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final contact = filtered[index];
                return _ContactCard(
                  contact:       contact,
                  avatarColor:   _avatarColor(contact.name),
                  avatarTextColor: _avatarTextColor(contact.name),
                  onDelete: () => _deleteContact(contact),
                );
              },
            ),
          ),
        ],
      ),

      // ── BOTTOM NAV ───────────────────────────────────────────────────────────
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0: Navigator.pushReplacementNamed(context, '/home'); break;
            case 1: Navigator.pushReplacementNamed(context, '/setup'); break;
            case 2: Navigator.pushReplacementNamed(context, '/contacts'); break;
            case 3: Navigator.pushReplacementNamed(context, '/history'); break;
            case 4: Navigator.pushReplacementNamed(context, '/settings'); break;
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CONTACT CARD WIDGET
// ─────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  final Contact contact;
  final Color   avatarColor;
  final Color   avatarTextColor;
  final VoidCallback onDelete;

  const _ContactCard({
    required this.contact,
    required this.avatarColor,
    required this.avatarTextColor,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // ── Avatar ────────────────────────────────────────────────────────
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              contact.name[0].toUpperCase(),
              style: TextStyle(
                color: avatarTextColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // ── Name & Phone ──────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                    color: Color(0xFF1A1D2E),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined,
                        size: 16, color: Color(0xFF9098B3)),
                    const SizedBox(width: 4),
                    Text(
                      contact.phone,
                      style: const TextStyle(
                        color: Color(0xFF9098B3),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Delete Icon ───────────────────────────────────────────────────
          GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.delete_outline,
                color: Color(0xFFB0B7C8), size: 22),
          ),
        ],
      ),
    );
  }
}