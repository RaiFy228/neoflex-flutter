import 'package:flutter/material.dart';

// Класс Book представляет модель книги с названием и автором.
class Book {
  final String title;
  final String author;

  Book(this.title, this.author); // Конструктор класса Book.
}

// Главный виджет приложения.
class App4 extends StatefulWidget {
  const App4({super.key});

  @override
  State<StatefulWidget> createState() => _App4State();
}

// Состояние виджета App4, которое реализует маршрутизацию с помощью Router API.
class _App4State extends State<App4> {
  final BookRouterDelegate _routerDelegate = BookRouterDelegate(); // Делегат маршрутизации.
  final BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser(); // Парсер информации о маршрутах.

  @override
  Widget build(BuildContext context) {
    // Создаем MaterialApp с поддержкой маршрутов.
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate, // Делегат маршрутизации.
      routeInformationParser: _routeInformationParser, // Парсер маршрутов.
    );
  }
}

// Парсер маршрутов, преобразует URL в объект BookRoutePath.
class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!); // Разбираем URI.
    if (uri.pathSegments.isEmpty) {
      return BookRoutePath.home(); // Путь к главной странице.
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') {
        return BookRoutePath.unknown(); // Неизвестный путь.
      }
      var id = int.tryParse(uri.pathSegments[1]);
      if (id == null) {
        return BookRoutePath.unknown(); // Некорректный ID.
      }
      return BookRoutePath.details(id); // Путь к деталям книги.
    }

    return BookRoutePath.unknown(); // Неизвестный маршрут.
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath configuration) {
    // Восстанавливаем маршрут на основе состояния.
    if (configuration.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (configuration.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/book/${configuration.id}');
    }
    return RouteInformation(location: '/');
  }
}

// Делегат маршрутизации, управляющий состоянием приложения.
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  Book? _selectedBook; // Выбранная книга.
  bool show404 = false; // Флаг для отображения страницы 404.

  List<Book> books = [
    Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
    Book('Too Like the Lightning', 'Ada Palmer'),
    Book('Kindred', 'Octavia E. Butler'),
  ]; // Список книг.

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  BookRoutePath get currentConfiguration {
    // Возвращаем текущее состояние маршрута.
    if (show404) {
      return BookRoutePath.unknown();
    }
    return _selectedBook == null
        ? BookRoutePath.home()
        : BookRoutePath.details(books.indexOf(_selectedBook!));
  }

  @override
  Widget build(BuildContext context) {
    // Построение навигатора с определением текущих страниц.
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('BookListPage'),
          child: BooksListScreen(
            books: books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (show404)
          const MaterialPage(
            key: ValueKey('UnknownPage'),
            child: UnknownScreen(),
          )
        else if (_selectedBook != null)
          MaterialPage(
            key: ValueKey('BookDetailsPage'),
            child: BookDetailsScreen(book: _selectedBook!),
          ),
      ],
      onPopPage: (route, result) {
        // Обработка нажатия кнопки "Назад".
        if (!route.didPop(result)) {
          return false;
        }

        _selectedBook = null;
        show404 = false;
        notifyListeners(); // Уведомляем об изменении состояния.

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    // Обработка нового маршрута.
    if (configuration.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }

    if (configuration.isDetailsPage) {
      if (configuration.id! < 0 || configuration.id! > books.length - 1) {
        show404 = true;
        return;
      }
      _selectedBook = books[configuration.id!];
    } else {
      _selectedBook = null;
    }
    show404 = false;
  }

  void _handleBookTapped(Book book) {
    // Обработка выбора книги.
    if (book.title == 'unknown') {
      show404 = true;
    } else {
      _selectedBook = book;
    }
    notifyListeners(); // Уведомляем об изменении состояния.
  }
}

// Экран с деталями книги.
class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Center(
        child: Text('Author: ${book.author}'),
      ),
    );
  }
}

// Маршрутная информация для приложения.
class BookRoutePath {
  final int? id;
  final bool isUnknown;

  BookRoutePath.home()
      : id = null,
        isUnknown = false;

  BookRoutePath.details(this.id) : isUnknown = false;

  BookRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null && !isUnknown;

  bool get isDetailsPage => id != null;

  bool get isUnknownPage => isUnknown;
}

// Экран для отображения ошибки 404.
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404'),
      ),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  }
}

// Экран со списком книг.
class BooksListScreen extends StatelessWidget {
  const BooksListScreen(
      {super.key, required this.books, required this.onTapped});

  final List<Book> books; // Список книг.
  final ValueChanged<Book> onTapped; // Коллбэк на выбор книги.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books List'),
      ),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book), // Вызываем обработчик.
            ),
          ListTile(
            title: const Text('unknown'),
            subtitle: const Text('author'),
            onTap: () => onTapped(Book('unknown', 'author')),
          )
        ],
      ),
    );
  }
}
