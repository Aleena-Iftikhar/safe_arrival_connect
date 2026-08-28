import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'commonWidget/bottomNavigationBar.dart';
import 'providers/journey_provider.dart';
import 'models/journey_model.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  int _selectedIndex = 3;

  static const Color _bgPage = Color(0xFFF4F6FA);
  static const Color _textPrimary = Color(0xFF1A1D2E);
  static const Color _textSecondary = Color(0xFF9BA3B4);
  static const Color _primary = Color(0xFF5B6FD4);

  @override
  Widget build(BuildContext context) {
    final journeysAsync = ref.watch(journeyProvider);

    return Scaffold(
      backgroundColor: _bgPage,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(journeyProvider.notifier).refresh(),
          child: CustomScrollView(
            slivers: [
              // ── Page Header ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Journey History',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All your previously saved journeys',
                        style: TextStyle(fontSize: 16, color: _textSecondary),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Content: loading / error / empty / data ──
              journeysAsync.when(
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, stack) => SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.redAccent, size: 48),
                          const SizedBox(height: 12),
                          Text(
                            'Failed to load history\n$err',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: _textSecondary),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () =>
                                ref.read(journeyProvider.notifier).refresh(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                data: (journeys) {
                  if (journeys.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history,
                                color: _textSecondary.withValues(alpha: 0.5),
                                size: 56),
                            const SizedBox(height: 12),
                            const Text(
                              'No journeys saved yet',
                              style: TextStyle(
                                  color: _textSecondary, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final journey = journeys[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _JourneyHistoryTile(journey: journey),
                          );
                        },
                        childCount: journeys.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

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
// SINGLE JOURNEY TILE
// ─────────────────────────────────────────
class _JourneyHistoryTile extends StatelessWidget {
  final Journey journey;
  const _JourneyHistoryTile({required this.journey});

  static const Color _textPrimary = Color(0xFF1A1D2E);
  static const Color _textSecondary = Color(0xFF9BA3B4);

  bool get _isPending =>
      (journey.status ?? '').toLowerCase() == 'pending';

  String get _formattedDate {
    final date = journey.createdAt;
    if (date == null) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final ampm = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '${months[date.month - 1]} ${date.day} · $hour12:$minute $ampm';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              color: _isPending
                  ? const Color(0xFFFFF3E0)
                  : const Color(0xFFE6F9F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _isPending
                  ? Icons.access_time_rounded
                  : Icons.check_circle_outline_rounded,
              color: _isPending
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
                Text(
                  journey.destinationName.isNotEmpty
                      ? journey.destinationName
                      : 'Untitled destination',
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  journey.destinationAddress,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formattedDate,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 13,
                  ),
                ),
                if (journey.contacts.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: journey.contacts.map((c) {
                      return Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B6FD4).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          c['initial'] ?? '?',
                          style: const TextStyle(
                            color: Color(0xFF5B6FD4),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _isPending
                  ? const Color(0xFFFFF3E0)
                  : const Color(0xFFE6F9F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              journey.status ?? 'Saved',
              style: TextStyle(
                color: _isPending
                    ? const Color(0xFFE59C1A)
                    : const Color(0xFF3DB87A),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}