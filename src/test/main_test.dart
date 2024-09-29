
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.cubit_example/main.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('MainApp Tests', () {
		testWidgets('App starts with HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MainApp());

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('AnimalCubit Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		blocTest<AnimalCubit, Animal>(
			'emits [Animal(name: "Dog", icon: Icons.access_time)] when toggleAnimal is called after initial state',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [Animal(name: "Dog", icon: Icons.access_time)],
		);

		blocTest<AnimalCubit, Animal>(
			'emits [Animal(name: "Cat", icon: Icons.person)] when toggleAnimal is called twice',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal();
				cubit.toggleAnimal();
			},
			expect: () => [
				Animal(name: "Dog", icon: Icons.access_time),
				Animal(name: "Cat", icon: Icons.person),
			],
		);
	});

	group('HomeScreen Tests', () {
		late AnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('Displays initial animal as Cat with person icon', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: "Cat", icon: Icons.person));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('Tapping on the widget changes the animal to Dog with access time icon', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: "Cat", icon: Icons.person));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			// Assume the initial state
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);

			// Simulate tapping the widget
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([Animal(name: "Dog", icon: Icons.access_time)]),
			);

			await tester.tap(find.byType(AnimalWidget));
			await tester.pumpAndSettle();

			// Verify the state after tapping
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});
}
