// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ListService extends ListService {
  _$ListService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ListService;

  @override
  Future<Response> getList(Map<String, dynamic> body) {
    final $url = '/users';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getReadableLists(Map<String, dynamic> body) {
    final $url = '/users/readable_lists';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
