// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$LocationService extends LocationService {
  _$LocationService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = LocationService;

  @override
  Future<Response<dynamic>> postLocation(Map<dynamic, dynamic> body) {
    final $url = '/location';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
