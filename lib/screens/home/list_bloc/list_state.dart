import 'package:equatable/equatable.dart';
import 'package:your_list_flutter_app/models/lsit_model/built_myList.dart';


abstract class UsrListState extends Equatable {
  const UsrListState();

  @override
  List<Object> get props => [];
}

class UsrListUninitialized extends UsrListState {}

class PostError extends UsrListState {}

class PostLoaded extends UsrListState {
  final List<UsrList> posts;
  final bool hasReachedMax;

  const PostLoaded({
    this.posts,
    this.hasReachedMax,
  });

  PostLoaded copyWith({
    List<UsrList> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
