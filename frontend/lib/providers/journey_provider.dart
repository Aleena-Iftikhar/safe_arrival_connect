import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/journey_model.dart';

class JourneyNotifier extends AsyncNotifier<List<Journey>> {
  static const String baseUrl = 'http://10.0.2.2:3000';

  @override
  Future<List<Journey>> build() async {
    return _fetchJourneys();
  }

  Future<List<Journey>> _fetchJourneys() async {
    final response = await http.get(Uri.parse('$baseUrl/journey/all'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded['success'] == true) {
        final List<dynamic> data = decoded['data'];
        return data.map((e) => Journey.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load journeys');
    }
  }

  // Manual refresh
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchJourneys());
  }

  // Setup Journey screen calls this on save button click
  Future<bool> saveJourney(Map<String, dynamic> journeyData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/journey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(journeyData),
      );

      final result = jsonDecode(response.body);

      if (result['success'] == true) {
        // List refresh after Backend confirm
        await refresh();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

final journeyProvider =
AsyncNotifierProvider<JourneyNotifier, List<Journey>>(() {
  return JourneyNotifier();
});

// helper provider for dashboard (latest journey)
final latestJourneyProvider = Provider<Journey?>((ref) {
  final journeysAsync = ref.watch(journeyProvider);
  return journeysAsync.when(
    data: (journeys) => journeys.isNotEmpty ? journeys.first : null,
    loading: () => null,
    error: (_, __) => null,
  );
});