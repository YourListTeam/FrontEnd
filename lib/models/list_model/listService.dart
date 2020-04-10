
import 'package:your_list_flutter_app/res/val/strings.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';

import 'package:built_collection/built_collection.dart';

import 'built_myList.dart';

part 'listService.chopper.dart';

@ChopperApi(baseUrl: "/lists")
abstract class ListService extends ChopperService{

  @Get(path: "/readable_lists")
  Future<Response<List<String>>> getLists(@Body() Map<dynamic, dynamic> body);

  @Get()
  Future<Response> getList(@Body() Map<dynamic, dynamic> body);

  @Post()
  Future<Response> postList(@Body() Map<dynamic, dynamic> body);

  @Delete()
  Future<Response> deleteList(@Body() Map<dynamic, dynamic> body);

  static ListService create() {
    final client = ChopperClient(
      baseUrl: GlobalStrings.url,
      services: [
        _$ListService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$ListService(client);
  }
}