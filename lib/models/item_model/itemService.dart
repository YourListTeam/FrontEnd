
import 'package:your_list_flutter_app/res/val/strings.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';

import 'package:built_collection/built_collection.dart';
import 'built_myItem.dart';

part "itemService.chopper.dart";

@ChopperApi(baseUrl: "/items")
abstract class ItemService extends ChopperService{

  @Get(path: "/many")
  Future<Response<List<Map<dynamic, dynamic>>>> getItems(@Body() Map<dynamic, dynamic> body);

  @Put()
  Future<Response> putItem(@Body() Map<dynamic, dynamic> body);

  static ItemService create() {
    final client = ChopperClient(
      baseUrl: GlobalStrings.url,
      services: [
        _$ItemService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$ItemService(client);
  }
}