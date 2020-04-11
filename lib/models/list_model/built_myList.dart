
import 'package:equatable/equatable.dart';


/// This is an object which is used to store information about the list
/// all of this information is obtained from node server
/// This class is mainly used to make it easier to display information
/// in home_list.dart
class UsrList extends Equatable {
  final String lid;
  final String title;
  final String colour;
  final String date;
  final String hex;
  String location;
  String address;

  UsrList({this.title, this.colour, this.lid, this.date, this.hex, this.location, this.address});

  @override
  List<Object> get props => [title, colour, lid];

  @override
  String toString() => 'Post { lid: $lid }';
}