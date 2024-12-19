import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Главная функция приложения
void main() {
  asyncExample();          // Пример работы с асинхронным программированием
  baseExample();           // Пример базовых возможностей языка
  nullSafetyExample();     // Пример использования null-безопасности
  oopExample();            // Пример объектно-ориентированного программирования
  collectionsExample();    // Пример работы с коллекциями
  recordsExapmle();        // Пример использования кортежей (Records)
  generatorsExample();     // Пример работы с генераторами
}

// Определение класса User с параметрами, допускающими null
class User {
  int? age;
  String? name;

  User({this.age, this.name});
}

// Константа count
const count = 5;

// Пример базовых возможностей Dart
void baseExample() {
  print('count = $count');
  
  // Работа с переменными
  var countVar = 5;
  countVar++;
  print('countVar = ${countVar.runtimeType}');
  print('countVar = $countVar');

  // Работа с коллекциями
  final List<int> list = [];
  list.add(1);
  print(list);
}

// Пример работы с null-безопасностью
void nullSafetyExample() {
  int? count = 5;
  count = null;
  
  // Использование оператора ?? для значения по умолчанию
  int num2 = count ?? 0;
  print(num2);

  // Работа с объектами, допускающими null
  User? user;
  user?.age = 5;

  User? user1;
  user1
    ?..age = 5
    ..name = '';

  // Использование late для отложенной инициализации
  late final int count1;
  count1 = 5;
  print(count1);
}

// Метод, выбрасывающий исключение
Never valueIsNotDefined() {
  throw ArgumentError('Value is not defined');
}

// Проверка и обработка значений null
int method(int? value) {
  if (value == null) {
    return valueIsNotDefined();
  }
  return value;
}

// Абстрактный класс Person
abstract class Person {
  final String name;
  final int age;
  final bool sex;

  Person({required this.name, required this.age, required this.sex});
}

// Класс Student, наследующий Person
class Student extends Person {
  Student(this.avgScore,
      {required super.name, required super.age, required super.sex});

  final int avgScore;
}

// Класс Man, реализующий интерфейс Person
class Man implements Person {
  @override
  final String name;
  @override
  final int age;

  Man({required this.age, required this.name});

  @override
  bool get sex => true;
}

// Расширение для класса Man
extension ManExtension on Man {
  bool get isOld {
    if (age > 65) {
      return true;
    } else {
      return false;
    }
  }
}

// Пример объектно-ориентированного программирования
void oopExample() {
  Person p = Student(5, name: "Name", age: 20, sex: true);
  Man man = Man(age: 60, name: 'Test');
  
  // Использование расширения
  print(man.isOld);
  print(p);
}

// Пример работы с коллекциями
void collectionsExample() {
  final list = ['Item1', 'Item2', 'Item3', 3];
  print(list);

  final list1 = List<String>.empty(growable: true);
  list1.add('Item1');
  print(list1);

  final map = {
    'key1': 'value1',
  };
  print(map['key1']);
}

// Пример работы с кортежами
void recordsExapmle() {
  var item = ("Name", 30);          // Кортеж с позиционными элементами
  print(item.$1);

  (String, int, int) item2 = ('Name2', 3, 2);
  print(item2);

  var item3 = (name: 'Name3', age: 5); // Кортеж с именованными элементами
  print(item3.age);
}

// Пример работы с асинхронным программированием
void asyncExample() async {
  final result = await Future.delayed(Duration(seconds: 2), () async {
    return 'String';
  });
  
  await Future.delayed(Duration(seconds: 2));
  print(result);
}

// Пример работы с генераторами
void generatorsExample() async {
  print(naturalsTo(5).take(3)); // Генератор синхронный
  asynchronousNaturalsTo(5).listen((event) {
    print(event);              // Генератор асинхронный
  });
}

// Синхронный генератор
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) {
    print('yield = $k');
    yield k++;
  }
}

// Асинхронный генератор
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) {
    await Future.delayed(Duration(seconds: 1));
    yield k++;
  }
}
