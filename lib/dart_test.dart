import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';

int calculate() {
  return 6 * 7;
}

class VendingMachine {
  Food? _selectedFood;
  String? _name;
  int? _qty;
  int? _money;

  String? get name => _name;

  set name(String? value) {
    List<Food> foods = getFoods();
    _selectedFood = foods.firstWhere(
        (element) => element.name.toLowerCase() == value?.toLowerCase(),
        orElse: () => Food.empty);
    if (_selectedFood == null || _selectedFood!.isEmpty) {
      stderr.writeln();
      stderr.writeln('Food not found.');
      exit(2);
    }
  }

  int? get qty => _qty;

  set qty(dynamic value) {
    _qty = int.tryParse(value) ?? 0;

    if (_qty! <= 0) {
      stderr.writeln();
      stderr.writeln('Qty "$value" is not valid.');
      exit(2);
    }

    if (_qty! > _selectedFood!.qty) {
      stderr.writeln();
      stderr.writeln(
          '${_selectedFood?.name} only remains ${_selectedFood?.qty}.');
      exit(2);
    }
  }

  int? get money => _money;

  set money(dynamic value) {
    _money = int.tryParse(value) ?? 0;

    if (_money! <= 0) {
      stderr.writeln();
      stderr.writeln('Money "$_money" is not valid.');
      exit(2);
    }

    if ((_selectedFood!.price * _qty!) > _money!) {
      stderr.writeln();
      stderr.writeln('Sorry, your money isn\'t enough.');
      exit(2);
    }

    bool isAcceptableMoney = false;
    for (var money in acceptableMoney) {
      if (money * 2 == _money!) {
        isAcceptableMoney = true;
      }
    }

    if (!acceptableMoney.contains(_money) && !isAcceptableMoney) {
      stderr.writeln();
      stderr.writeln('Sorry, we don\'t accept "$_money".');
      exit(2);
    }
  }

  List<int> acceptableMoney = [2000, 5000, 10000, 20000, 50000];

  void calculate() {
    if (_money! - (_selectedFood!.price * _qty!) > 0) {
      stderr.writeln();
      stdout.writeln('====================');
      stdout.writeln('Your Order Summary');
      stderr.writeln('====================');
      stderr.writeln();
      stdout.writeln('Food Name: ${_selectedFood?.name}');
      stdout.writeln('Food Price: ${_selectedFood?.price}');
      stdout.writeln('Qty: $_qty');
      stdout.writeln('Total: ${_selectedFood!.price * _qty!}');
      stdout.writeln('Your money: $_money');
      stdout.writeln('Change: ${_money! - (_selectedFood!.price * _qty!)}');
      stderr.writeln();
      stdout.writeln('====================');
      stderr.writeln('Thank you!');
      stdout.writeln('====================');
      stderr.writeln();
      exit(0);
    }
  }

  int get totalFoods => getFoods().length;

  List<Food> getFoods() {
    List<Food> foods = [];

    foods.add(Food(name: 'Biskuit', price: 6000, qty: 5));
    foods.add(Food(name: 'Chips', price: 8000, qty: 3));
    foods.add(Food(name: 'Oreo', price: 10000, qty: 6));
    foods.add(Food(name: 'Tango', price: 12000, qty: 4));
    foods.add(
        Food(name: 'Cokelat', price: 15000, qty: Random().nextInt(10) + 1));

    return foods;
  }
}

class Food extends Equatable {
  final String name;
  final int price;
  final int qty;

  const Food({required this.name, required this.price, required this.qty});

  static const empty = Food(name: 'Unknown', price: 0, qty: 0);

  bool get isEmpty => this == Food.empty;

  bool get isNotEmpty => this != Food.empty;

  @override
  List<Object?> get props => [name, price, qty];
}
