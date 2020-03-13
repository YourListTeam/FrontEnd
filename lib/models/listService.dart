import 'package:your_list_flutter_app/res/val/strings.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';
part 'listService.chopper.dart';

@ChopperApi(baseUrl: "/users")
abstract class ListService extends ChopperService {
  @Get()
  Future<Response> getList(@Body() Map<String, dynamic> body);

  @Get(path: '/readable_lists')
  Future<Response> getReadableLists(@Body() Map<String, dynamic> body);

  static ListService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: GlobalStrings.url,
      services: [
        // The generated implementation
        _$ListService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$ListService(client);
  }
}
