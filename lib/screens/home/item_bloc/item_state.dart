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

class PostError extends UsrItemState {}

class PostLoaded extends UsrItemState {
  final List<UsrItem> posts;

  const PostLoaded({
    this.posts
  });

  PostLoaded copyWith({
    List<UsrItem> posts,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [posts];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length} }';
}
