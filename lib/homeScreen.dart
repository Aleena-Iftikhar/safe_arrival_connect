
// HOME SCREEN


import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.location_on_outlined, label: 'Setup'),
    _NavItem(icon: Icons.people_outline_rounded, label: 'Contacts'),
    _NavItem(icon: Icons.access_time_outlined, label: 'History'),
    _NavItem(icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header Card (blue gradient) ──
              _HeaderCard(),
              const SizedBox(height: 16),

              // ── Info Cards ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _InfoCard(
                      icon: Icons.location_on_outlined,
                      iconBgColor: const Color(0xFFE8EEFF),
                      iconColor: const Color(0xFF5B6FD4),
                      label: 'DESTINATION',
                      title: 'University Hostel',
                      subtitle: 'Punjab University, Lahore',
                    ),
                    const SizedBox(height: 12),
                    _RecipientsCard(),
                    const SizedBox(height: 12),
                    _ArrivalMessageCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // ── Recent Journeys ──
              _RecentJourneysSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomNav(
        items: _navItems,
        selectedIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}

// ─────────────────────────────────────────
// HEADER CARD
// ─────────────────────────────────────────
class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5B6FD4), Color(0xFF7B8FE8)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App name row
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SafeArrive',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    'Arrive Safe. Stay Connected.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Start Journey button
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow_rounded,
                    color: Color(0xFF5B6FD4), size: 22),
                SizedBox(width: 8),
                Text(
                  'Start Journey',
                  style: TextStyle(
                    color: Color(0xFF5B6FD4),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// GENERIC INFO CARD
// ─────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String label;
  final String title;
  final String subtitle;

  const _InfoCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.label,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Color(0xFF9BA3B4),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8)),
                const SizedBox(height: 2),
                Text(title,
                    style: const TextStyle(
                        color: Color(0xFF1A1D2E),
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: Color(0xFF9BA3B4), fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFCDD2DE), size: 22),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// RECIPIENTS CARD
// ─────────────────────────────────────────
class _RecipientsCard extends StatelessWidget {
  final List<_Contact> contacts = const [
    _Contact(initial: 'M', color: Color(0xFF5B6FD4)),
    _Contact(initial: 'D', color: Color(0xFF3DB87A)),
    _Contact(initial: 'A', color: Color(0xFFE85B7A)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F9F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.people_outline_rounded,
                color: Color(0xFF3DB87A), size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RECIPIENTS',
                    style: TextStyle(
                        color: Color(0xFF9BA3B4),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8)),
                const SizedBox(height: 2),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Mom, Dad ',
                        style: TextStyle(
                            color: Color(0xFF1A1D2E),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: '+1 contacts',
                        style: TextStyle(
                            color: Color(0xFF5B6FD4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: contacts
                      .map((c) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: _ContactBadge(contact: c),
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFCDD2DE), size: 22),
        ],
      ),
    );
  }
}

class _Contact {
  final String initial;
  final Color color;
  const _Contact({required this.initial, required this.color});
}

class _ContactBadge extends StatelessWidget {
  final _Contact contact;
  const _ContactBadge({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: contact.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: contact.color.withOpacity(0.3), width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        contact.initial,
        style: TextStyle(
            color: contact.color,
            fontSize: 12,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

// ─────────────────────────────────────────
// ARRIVAL MESSAGE CARD
// ─────────────────────────────────────────
class _ArrivalMessageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EEFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.chat_bubble_outline_rounded,
                color: Color(0xFF5B6FD4), size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ARRIVAL MESSAGE',
                    style: TextStyle(
                        color: Color(0xFF9BA3B4),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8)),
                const SizedBox(height: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Hi Mom, I have safely arrived at my destination. All is well! ❤️',
                    style: TextStyle(
                        color: Color(0xFF3A3F5C),
                        fontSize: 14,
                        height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// RECENT JOURNEYS SECTION
// ─────────────────────────────────────────
class _RecentJourneysSection extends StatelessWidget {
  final List<_JourneyItem> journeys = const [
    _JourneyItem(
      destination: 'University Hostel',
      dateTime: 'Apr 18 · 06:19 PM',
      status: 'Sent',
      isPending: false,
    ),
    _JourneyItem(
      destination: 'Office, Gulberg',
      dateTime: 'Apr 16 · 06:19 PM',
      status: 'Sent',
      isPending: false,
    ),
    _JourneyItem(
      destination: "Aunt's House, DHA",
      dateTime: 'Apr 14 · 06:19 PM',
      status: 'Pending',
      isPending: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent journeys',
                  style: TextStyle(
                      color: Color(0xFF1A1D2E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Text('See all',
                  style: TextStyle(
                      color: const Color(0xFF5B6FD4),
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: journeys.asMap().entries.map((entry) {
              final i = entry.key;
              final j = entry.value;
              return Column(
                children: [
                  _JourneyTile(item: j),
                  if (i < journeys.length - 1)
                    const Divider(
                        height: 1,
                        thickness: 0.5,
                        indent: 72,
                        color: Color(0xFFF0F2F7)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _JourneyItem {
  final String destination;
  final String dateTime;
  final String status;
  final bool isPending;
  const _JourneyItem({
    required this.destination,
    required this.dateTime,
    required this.status,
    required this.isPending,
  });
}

class _JourneyTile extends StatelessWidget {
  final _JourneyItem item;
  const _JourneyTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: item.isPending
                  ? const Color(0xFFFFF3E0)
                  : const Color(0xFFE6F9F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.isPending
                  ? Icons.access_time_rounded
                  : Icons.check_circle_outline_rounded,
              color: item.isPending
                  ? const Color(0xFFE59C1A)
                  : const Color(0xFF3DB87A),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.destination,
                    style: const TextStyle(
                        color: Color(0xFF1A1D2E),
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(item.dateTime,
                    style: const TextStyle(
                        color: Color(0xFF9BA3B4), fontSize: 13)),
              ],
            ),
          ),
          // Status badge
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: item.isPending
                  ? const Color(0xFFFFF3E0)
                  : const Color(0xFFE6F9F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item.status,
              style: TextStyle(
                color: item.isPending
                    ? const Color(0xFFE59C1A)
                    : const Color(0xFF3DB87A),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// BOTTOM NAVIGATION BAR
// ─────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

class _BottomNav extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F2F7), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
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
                        color: selected
                            ? const Color(0xFF5B6FD4)
                            : const Color(0xFFB0B7C8),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: selected
                              ? const Color(0xFF5B6FD4)
                              : const Color(0xFFB0B7C8),
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