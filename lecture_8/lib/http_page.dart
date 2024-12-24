import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lecture_8/album_model.dart';
import 'package:http/http.dart' as http;
import 'package:lecture_8/rest_album_provider.dart';

class AlbumHttpProvider {
  Future<List<AlbumModel>> fetchAlbums() async {
    final responce = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    final list = jsonDecode(responce.body);

    return (list as List).map((e) => AlbumModel.fromJson(e)).toList();
  }

  Future<int> createAlbum(AlbumModel albumModel) async {
    final responce = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
        body: jsonEncode(albumModel));

    return responce.statusCode;
  }
}

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  State<HttpPage> createState() => _HttpPage();
}

class _HttpPage extends State<HttpPage> {
  late final AlbumHttpProvider albumHttpProvider;
  late final RestAlbumProvider restAlbumProvider;

  Future<List<AlbumModel>>? future;

  @override
  void initState() {
    super.initState();
    albumHttpProvider = AlbumHttpProvider();
    restAlbumProvider = RestAlbumProvider(Dio());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          future = albumHttpProvider.fetchAlbums();
                          // future = restAlbumProvider.fetchAlbums();
                        });
                      },
                      child: const Text('Получить альбомы')),
                  ElevatedButton(
                      onPressed: () async {
                        final result = await albumHttpProvider.createAlbum(
                            AlbumModel(userId: 1, id: 1, title: 'test'));
                        // final result = await restAlbumProvider.createAlbum(AlbumModel(userId: 1, id: 1, title: 'test'));
                        if (mounted) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      Text('Запрос выполнен с кодом ${result}'),
                                );
                              });
                        }
                      },
                      child: const Text('Создать альбом')),
                ],
              ),
              FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.data != null && snapshot.hasData) {
                      return Column(
                        children: [
                          ...snapshot.data?.map((e) => Row(
                                    children: [
                                      Text('ID: ${e.id}'),
                                      Expanded(
                                          child: Text('Title: ${e.title}')),
                                    ],
                                  )) ??
                              []
                        ],
                      );
                    }
                    return const Text('No albums');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}