
import 'package:flutter/material.dart';

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
