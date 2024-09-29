
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cubit_example/cubits/animal_cubit.dart';
import 'package:cubit_example/models/animal.dart';
import 'package:flutter/material.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is Animal(name: "Cat", icon: Icons.person)', () {
			expect(animalCubit.state, Animal(name: 'Cat', icon: Icons.person));
		});

		blocTest<AnimalCubit, Animal>(
			'emits [Animal(name: "Dog", icon: Icons.access_time)] when toggleAnimal is called from initial state',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [Animal(name: 'Dog', icon: Icons.access_time)],
		);

		blocTest<AnimalCubit, Animal>(
			'emits [Animal(name: "Cat", icon: Icons.person)] when toggleAnimal is called from Dog state',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal(); // First toggle to Dog
				cubit.toggleAnimal(); // Second toggle back to Cat
			},
			expect: () => [
				Animal(name: 'Dog', icon: Icons.access_time),
				Animal(name: 'Cat', icon: Icons.person),
			],
		);
	});
}
