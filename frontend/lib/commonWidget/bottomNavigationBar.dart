import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  HOW TO USE IN ANY PAGE:
//
//  1. Import this file:
//     import 'bottom_nav.dart';
//
//  2. Add state in your page:
//     int _selectedIndex = 0; // change number per page
//
//  3. Add to your Scaffold:
//     bottomNavigationBar: BottomNav(
//       selectedIndex: _selectedIndex,
//       onTap: (index) => setState(() => _selectedIndex = index),
//     ),
//
//  INDEX REFERENCE:
//  0 = Home
//  1 = Setup
//  2 = Contacts
//  3 = History
//  4 = Settings
// ─────────────────────────────────────────────

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(icon: Icons.home_outlined,      label: 'Home'),
    _NavItem(icon: Icons.location_on_outlined, label: 'Setup'),
    _NavItem(icon: Icons.people_outline,     label: 'Contacts'),
    _NavItem(icon: Icons.history_outlined,   label: 'History'),
    _NavItem(icon: Icons.settings_outlined,  label: 'Settings'),
  ];

  static const Color _active   = Color(0xFF5B6FD4);
  static const Color _inactive = Color(0xFFB0B7C8);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF0F2F7), width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: _items.asMap().entries.map((entry) {
              final i        = entry.key;
              final item     = entry.value;
              final selected = i == selectedIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        color: selected ? _active : _inactive,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: selected ? _active : _inactive,
                          fontSize: 11,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PRIVATE HELPER CLASS (only used in this file)
// ─────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}