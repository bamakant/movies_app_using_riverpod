import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movies_app/main.dart';
import 'package:movies_app/model/movie_response.dart';
import 'package:movies_app/ui/home/repo/movie_repo.dart';
import 'package:movies_app/ui/home/viewmodel/movies_list_view_model.dart';

Widget createHomeScreen() => const ProviderScope(child: MoviesApp());

void main() {
  testWidgets('Bottom navigation bar is visible', (WidgetTester tester) async {
    final mockApiClient = MockMovieApiClient();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          moviesProvider
              .overrideWith((ref) => mockApiClient.getMovies('Latest'))
        ],
        child: createHomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    final bottomNavigationBar = find.byType(BottomNavigationBar);

    expect(bottomNavigationBar, findsOneWidget);
  });
}

class MockMovieApiClient implements MovieRepo {
  @override
  Future<List<Movie>> getMovies(String category) async {
    return [
      Movie(id: 1, title: 'Movie One'),
      Movie(id: 2, title: 'Movie Two'),
      Movie(id: 3, title: 'Movie Three'),
    ];
  }
}
