import 'package:equatable/equatable.dart';

class Messenger extends Equatable {
  const Messenger.failure({this.message = ''}) : error = true;
  const Messenger.success({this.message = ''}) : error = false;

  final bool error;
  final String message;
  @override
  List<Object> get props => [error, message];
}
