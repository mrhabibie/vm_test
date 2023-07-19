import 'dart:io';
import 'package:dart_test/dart_test.dart';

void main(List<String> arguments) {
  VendingMachine machine = VendingMachine();
  List<Food> foods = machine.getFoods();

  stdout.writeln('Welcome to Dart Vending Machine');
  stdout.writeln('We have ${machine.totalFoods} foods, such as :');
  stdout.writeln('====================');
  stdout.writeAll(
      foods
          .map((food) =>
              '${food.name} (Remains: ${food.qty} | Price: ${food.price})')
          .toList(),
      "\n");
  stdout.writeln('\n====================');
  stdout.writeln('Select your favourite food:');
  final inputName = stdin.readLineSync();
  stdout.writeln();
  machine.name = inputName;
  stdout.writeln('Please input qty:');
  final inputQty = stdin.readLineSync();
  stdout.writeln();
  machine.qty = inputQty;
  stdout.writeln(
      'Please insert your money (we only accept ${machine.acceptableMoney}):');
  final inputMoney = stdin.readLineSync();
  machine.money = inputMoney;

  stdout.writeln();
  machine.calculate();
}
