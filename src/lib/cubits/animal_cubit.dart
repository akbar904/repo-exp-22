
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/models/animal.dart';
import 'package:flutter/material.dart';

class AnimalCubit extends Cubit<Animal> {
	AnimalCubit() : super(Animal(name: 'Cat', icon: Icons.person));

	void toggleAnimal() {
		if (state.name == 'Cat') {
			emit(Animal(name: 'Dog', icon: Icons.access_time));
		} else {
			emit(Animal(name: 'Cat', icon: Icons.person));
		}
	}
}
