import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:your_list_flutter_app/models/lsit_model/lstBuilt.dart';


part 'serializers.g.dart';

@SerializersFor(const [BuiltMyList])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();