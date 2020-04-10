import 'package:equatable/equatable.dart';
import 'package:your_list_flutter_app/models/item_model/built_myItem.dart';


abstract class UsrItemState extends Equatable {
  const UsrItemState();

  @override
  List<Object> get props => [];

  getMap() {
  }
}

class UsrItemUninitialized extends UsrItemState {}

class ItemError extends UsrItemState {}

class ItemLoaded extends UsrItemState {
  final List<UsrItem> posts;

  const ItemLoaded({
    this.posts
  });

  ItemLoaded copyWith({
    List<UsrItem> posts,
  }) {
    return ItemLoaded(
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [posts];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length} }';
}
