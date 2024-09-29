
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/animal_cubit.dart';
import '../widgets/animal_widget.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text('Animal Toggle App')),
			body: BlocBuilder<AnimalCubit, Animal>(
				builder: (context, animal) {
					return GestureDetector(
						onTap: () => context.read<AnimalCubit>().toggleAnimal(),
						child: Center(
							child: AnimalWidget(animal: animal),
						),
					);
				},
			),
		);
	}
}
