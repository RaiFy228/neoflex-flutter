import 'package:flutter/material.dart';
import 'package:lecture_13/user.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final birthday = DateTime.now();

    final user1 = UserModel(
      login: 'user',
      firstName: 'firstName',
      lastName: 'lastName',
    );

    final user2 = UserModel(
      login: 'user',
      firstName: 'firstName',
      lastName: 'lastName',
    );

    print(user1 == user2); 
    print(UserModel.fromJson(user1.toJson())); 

    return Scaffold(
      body: Center(
        child: Text(user2.toString()), // Вывод информации о user2
      ),
    ); // Scaffold
  }
}
