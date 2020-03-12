// userService.dart

import 'package:your_list_flutter_app/res/val/strings.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';
part 'userService.chopper.dart';


@ChopperApi(baseUrl: "/users")
abstract class UserService extends ChopperService {

  @Get()
  Future<Response> getUsers();

  @Get()
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  Future<Response> getUser(@Body() Map<dynamic, dynamic> body);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post()
  Future<Response> postUser(
      @Body() Map<dynamic, dynamic> body,
      );

  static UserService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: GlobalStrings.url,
      services: [
        // The generated implementation
        _$UserService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );


    // The generated class with the ChopperClient passed in
    return _$UserService(client);
  }

}
