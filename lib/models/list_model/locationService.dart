
import 'package:your_list_flutter_app/res/val/strings.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';

import 'package:built_collection/built_collection.dart';

import 'built_myList.dart';

part 'locationService.chopper.dart';

@ChopperApi(baseUrl: "/location")
abstract class LocationService extends ChopperService{

  @Post()
  Future<Response> postLocation(@Body() Map<dynamic, dynamic> body);

  static LocationService create() {
    final client = ChopperClient(
      baseUrl: GlobalStrings.url,
      services: [
        _$LocationService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$LocationService(client);
  }
}