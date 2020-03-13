// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singleListService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SingleListService extends SingleListService {
  _$SingleListService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SingleListService;

  @override
  Future<Response<BuiltMyList>> getList(Map<dynamic, dynamic> body) {
    final $url = '/lists';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<BuiltMyList, BuiltMyList>($request);
  }
}
