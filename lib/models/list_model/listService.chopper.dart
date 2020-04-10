// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ListService extends ListService {
  _$ListService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ListService;

  @override
  Future<Response<List<String>>> getLists(Map<dynamic, dynamic> body) {
    final $url = '/lists/readable_lists';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> getList(Map<dynamic, dynamic> body) {
    final $url = '/lists';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postList(Map<dynamic, dynamic> body) {
    final $url = '/lists';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteList(Map<dynamic, dynamic> body) {
    final $url = '/lists';
    final $body = body;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
