// userService.dart

import 'package:your_list_flutter_app/res/val/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
//abstract class UserService {
//  http.Client client;
//
//  Future<http.Response> getUserWithUuid();
//  Future<http.Response> setUser(String uuid);
//
//  static UserService create() {
//    final client = http.Client();
//    return  _$UserService(client);
//  }
//
//}
//
//class _$UserService extends UserService  {
//  var urlLoc = "/posts";
//  _$UserService([http.Client client]) {
//    if (client == null) return;
//    this.client = client;
//  }
//
//  @override
//  Future<http.Response> getUserWithUuid() async{
//    var reqTo = GlobalStrings.url + urlLoc;
//    var responce = await client.get(reqTo);
//    return responce;
//  }
//
//  @override
//  Future<http.Response> setUser(String uuid) {
//    // TODO: implement setUser
//    throw UnimplementedError();
//  }
//
//
//}
import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
part 'userService.chopper.dart';


@ChopperApi(baseUrl: "/users")
abstract class UserService extends ChopperService {
//  static UserService create([ChopperClient client]) => _$UserService(client);

//  @Get(headers: const {})
  @Get()
  Future<Response> getUsers();

  @Get(headers: const {"UUID" : "uuid"})
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  Future<Response> getUser(@Query('UUID') String uuid);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post()
  Future<Response> postPost(
      @Body() Map<String, dynamic> body,
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
  // These ones can be used for testing
  @Get()
  Future<Response> getPosts();

}
