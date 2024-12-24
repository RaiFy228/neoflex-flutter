import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lecture_8/album_model.dart';
import 'package:retrofit/http.dart';

part 'rest_album_provider.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class RestAlbumProvider {
  factory RestAlbumProvider(Dio dio, {String baseUrl}) = _RestAlbumProvider;

  @GET('/albums')
  Future<List<AlbumModel>> fetchAlbums();

  @POST('/albums')
  Future<int> createAlbum(@Body() AlbumModel albumModel);
}