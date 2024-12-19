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
  int? age;                // Поле для хранения возраста пользователя
  String? name;            // Поле для хранения имени пользователя

  User({this.age, this.name}); // Конструктор класса User
}

// Константа count
const count = 5;

// Пример базовых возможностей Dart
void baseExample() {
  print('count = $count'); // Выводит: count = 5

  // Работа с переменными
  var countVar = 5;        // Переменная с типом int, значение 5
  countVar++;              // Увеличиваем значение переменной на 1
  print('countVar = ${countVar.runtimeType}'); // Выводит: countVar = int
  print('countVar = $countVar');              // Выводит: countVar = 6

  // Работа с коллекциями
  final List<int> list = []; // Создаем пустой список целых чисел
  list.add(1);               // Добавляем элемент в список
  print(list);               // Выводит: [1]
}

// Пример работы с null-безопасностью
void nullSafetyExample() {
  int? count = 5;           // Переменная с возможным значением null
  count = null;             // Присваиваем значение null

  // Использование оператора ?? для значения по умолчанию
  int num2 = count ?? 0;    // Если count == null, то num2 будет 0
  print(num2);              // Выводит: 0

  // Работа с объектами, допускающими null
  User? user;               // Объект класса User, который может быть null
  user?.age = 5;            // Безопасное присваивание значения (ничего не делает, так как user == null)

  User? user1;              // Еще один объект класса User
  user1
    ?..age = 5             // Безопасное присваивание значения полю age
    ..name = '';           // Безопасное присваивание значения полю name

  // Использование late для отложенной инициализации
  late final int count1;    // Переменная, которая инициализируется позже
  count1 = 5;               // Присваиваем значение
  print(count1);            // Выводит: 5
}

// Метод, выбрасывающий исключение
Never valueIsNotDefined() {
  throw ArgumentError('Value is not defined'); // Выбрасываем исключение
}

// Проверка и обработка значений null
int method(int? value) {
  if (value == null) {
    return valueIsNotDefined(); // Если value == null, выбрасываем исключение
  }
  return value;                // Возвращаем значение
}

// Абстрактный класс Person
abstract class Person {
  final String name;          // Имя
  final int age;              // Возраст
  final bool sex;             // Пол (true = мужской, false = женский)

  Person({required this.name, required this.age, required this.sex});
}

// Класс Student, наследующий Person
class Student extends Person {
  Student(this.avgScore,
      {required super.name, required super.age, required super.sex});

  final int avgScore;         // Средний балл студента
}

// Класс Man, реализующий интерфейс Person
class Man implements Person {
  @override
  final String name;
  @override
  final int age;

  Man({required this.age, required this.name});

  @override
  bool get sex => true;       // Реализация свойства sex (всегда true)
}

// Расширение для класса Man
extension ManExtension on Man {
  bool get isOld {             // Возраст больше 65 лет считается "старым"
    if (age > 65) {
      return true;
    } else {
      return false;
    }
  }
}

// Пример объектно-ориентированного программирования
void oopExample() {
  Person p = Student(5, name: "Name", age: 20, sex: true); // Создаем объект Student
  Man man = Man(age: 60, name: 'Test');                    // Создаем объект Man

  print(man.isOld);       // Выводит: false (возраст меньше 65)
  print(p);               // Выводит информацию об объекте Student
}

// Пример работы с коллекциями
void collectionsExample() {
  final list = ['Item1', 'Item2', 'Item3', 3]; // Список с элементами разных типов
  print(list);               // Выводит: [Item1, Item2, Item3, 3]

  final list1 = List<String>.empty(growable: true); // Создаем пустой список строк
  list1.add('Item1');        // Добавляем элемент в список
  print(list1);              // Выводит: [Item1]

  final map = {              // Создаем map (ассоциативный массив)
    'key1': 'value1',
  };
  print(map['key1']);        // Выводит: value1
}

// Пример работы с кортежами
void recordsExapmle() {
  var item = ("Name", 30);  // Кортеж с позиционными элементами
  print(item.$1);            // Выводит: Name (первый элемент кортежа)

  (String, int, int) item2 = ('Name2', 3, 2); // Кортеж с фиксированными типами
  print(item2);             // Выводит: (Name2, 3, 2)

  var item3 = (name: 'Name3', age: 5); // Кортеж с именованными элементами
  print(item3.age);        // Выводит: 5
}

// Пример работы с асинхронным программированием
void asyncExample() async {
  final result = await Future.delayed(Duration(seconds: 2), () async {
    return 'String';         // Возвращаем строку после задержки
  });

  await Future.delayed(Duration(seconds: 2)); // Ждем 2 секунды
  print(result);             // Выводит: String
}

// Пример работы с генераторами
void generatorsExample() async {
  print(naturalsTo(5).take(3)); // Выводит: (0, 1, 2)

  asynchronousNaturalsTo(5).listen((event) { // Асинхронный генератор
    print(event);           // Выводит числа от 0 до 4 с задержкой в 1 секунду
  });
}

// Синхронный генератор
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) {
    print('yield = $k');    // Печатаем текущий элемент
    yield k++;              // Возвращаем текущий элемент и увеличиваем k
  }
}

// Асинхронный генератор
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) {
    await Future.delayed(Duration(seconds: 1)); // Задержка в 1 секунду
    yield k++;              // Возвращаем текущий элемент и увеличиваем k
  }
}