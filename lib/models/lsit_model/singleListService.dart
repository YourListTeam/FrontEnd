
import 'package:your_list_flutter_app/models/lsit_model/lstBuilt.dart';
import 'package:your_list_flutter_app/res/val/strings.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';

import 'package:built_collection/built_collection.dart';
import 'built_value_converter.dart';

import 'built_myList.dart';

part 'singleListService.chopper.dart';

@ChopperApi(baseUrl: "/lists")
abstract class SingleListService extends ChopperService{

  @Get()
  Future<Response<BuiltMyList>> getList(@Body() Map<dynamic, dynamic> body);

  static SingleListService create() {
    final client = ChopperClient(
      baseUrl: GlobalStrings.url,
      services: [
        _$SingleListService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$SingleListService(client);
  }
}