import 'package:flutter/material.dart';
import 'commonWidget/bottomNavigationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderCard(),
              const SizedBox(height: 16),
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
              _RecentJourneysSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // BOTTOM BAR
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
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.shield_outlined,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SafeArrive',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3)),
                  Text('Arrive Safe. Stay Connected.',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
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
                    color: Color(0xFF5B6FD4), size: 24),
                SizedBox(width: 8),
                Text('Start Journey',
                    style: TextStyle(
                        color: Color(0xFF5B6FD4),
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
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
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: iconBgColor, borderRadius: BorderRadius.circular(12)),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8)),
                const SizedBox(height: 2),
                Text(title,
                    style: const TextStyle(
                        color: Color(0xFF1A1D2E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: Color(0xFF9BA3B4), fontSize: 16)),
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
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFFE6F9F0),
                borderRadius: BorderRadius.circular(12)),
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
                        fontSize: 16,
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
                            fontSize: 18,
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
      child: Text(contact.initial,
          style: TextStyle(
              color: contact.color,
              fontSize: 16,
              fontWeight: FontWeight.w700)),
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
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFFE8EEFF),
                borderRadius: BorderRadius.circular(12)),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF4F6FA),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    'Hi Mom, I have safely arrived at my destination. All is well! ❤️',
                    style: TextStyle(
                        color: Color(0xFF3A3F5C), fontSize: 16, height: 1.5),
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
        isPending: false),
    _JourneyItem(
        destination: 'Office, Gulberg',
        dateTime: 'Apr 16 · 06:19 PM',
        status: 'Sent',
        isPending: false),
    _JourneyItem(
        destination: "Aunt's House, DHA",
        dateTime: 'Apr 14 · 06:19 PM',
        status: 'Pending',
        isPending: true),
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
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
              const Text('See all',
                  style: TextStyle(
                      color: Color(0xFF5B6FD4),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.destination,
                    style: const TextStyle(
                        color: Color(0xFF1A1D2E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(item.dateTime,
                    style: const TextStyle(
                        color: Color(0xFF9BA3B4), fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}