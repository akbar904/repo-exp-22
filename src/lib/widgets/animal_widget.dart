
import 'package:flutter/material.dart';
import 'package:cubit_example/models/animal.dart';

class AnimalWidget extends StatelessWidget {
	final Animal animal;

	const AnimalWidget({Key? key, required this.animal}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Row(
			children: [
				Icon(animal.icon),
				SizedBox(width: 8),
				Text(animal.name),
			],
		);
	}
}
