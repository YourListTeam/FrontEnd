// userService.dart

import 'package:your_list_flutter_app/res/val/strings.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';
part 'userService.chopper.dart';


@ChopperApi(baseUrl: "/users")
/// ATTENTION: DO NOT MODIFY userService.chopper.dart it is auto
/// generated by flutter build runner
///
/// This service is responsible for obtaining user information from node server
///
/// For more information read how ChopperService works
abstract class UserService extends ChopperService {

  @Get()
  Future<Response> getUsers();

  @Get()
  /// getUser requires parameter UUID in body
  Future<Response> getUser(@Body() Map<dynamic, dynamic> body);

  /// postUser requires parameters UUID, email, name in body
  @Post()
  Future<Response> postUser(
      @Body() Map<dynamic, dynamic> body,
      );

  static UserService create() {
    final client = ChopperClient(
      baseUrl: GlobalStrings.url,
      services: [
        _$UserService(),
      ],
      converter: JsonConverter(),
    );


    return _$UserService(client);
  }

}
