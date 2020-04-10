// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ItemService extends ItemService {
  _$ItemService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ItemService;

  @override
  Future<Response<List<Map<dynamic, dynamic>>>> getItems(
      Map<dynamic, dynamic> body) {
    final $url = '/items/many';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client
        .send<List<Map<dynamic, dynamic>>, Map<dynamic, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> putItem(Map<dynamic, dynamic> body) {
    final $url = '/items';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
