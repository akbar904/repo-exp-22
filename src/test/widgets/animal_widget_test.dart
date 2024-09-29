
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cubit_example/widgets/animal_widget.dart';

// Mock Animal model
class MockAnimal extends Mock implements Animal {}

void main() {
	group('AnimalWidget Tests', () {
		testWidgets('displays the correct animal name and icon', (WidgetTester tester) async {
			// Arrange
			final mockAnimal = MockAnimal();
			when(() => mockAnimal.name).thenReturn('Cat');
			when(() => mockAnimal.icon).thenReturn(Icons.person);

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: AnimalWidget(animal: mockAnimal),
					),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('updates the animal name and icon on state change', (WidgetTester tester) async {
			// Arrange
			final mockAnimal = MockAnimal();
			final updatedAnimal = MockAnimal();
			when(() => mockAnimal.name).thenReturn('Cat');
			when(() => mockAnimal.icon).thenReturn(Icons.person);
			when(() => updatedAnimal.name).thenReturn('Dog');
			when(() => updatedAnimal.icon).thenReturn(Icons.access_time);

			Widget buildWidget(Animal animal) {
				return MaterialApp(
					home: Scaffold(
						body: AnimalWidget(animal: animal),
					),
				);
			}

			// Act
			await tester.pumpWidget(buildWidget(mockAnimal));

			// Assert initial state
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);

			// Act - update state
			await tester.pumpWidget(buildWidget(updatedAnimal));

			// Assert updated state
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});
}
