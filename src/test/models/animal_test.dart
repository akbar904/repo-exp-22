
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cubit_example/models/animal.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal should be instantiated with correct name and icon', () {
			final animal = Animal('Cat', Icons.person);

			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.person);
		});

		test('Animal should serialize to JSON', () {
			final animal = Animal('Cat', Icons.person);
			final json = {'name': 'Cat', 'icon': Icons.person.codePoint};

			expect(animal.toJson(), json);
		});

		test('Animal should deserialize from JSON', () {
			final json = {'name': 'Cat', 'icon': Icons.person.codePoint};
			final animal = Animal.fromJson(json);

			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.person);
		});
	});
}

class Animal {
	final String name;
	final IconData icon;

	Animal(this.name, this.icon);

	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'icon': icon.codePoint,
		};
	}

	factory Animal.fromJson(Map<String, dynamic> json) {
		return Animal(
			json['name'] as String,
			IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
		);
	}
}
