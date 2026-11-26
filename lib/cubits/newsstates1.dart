import 'package:newsappp/newmodel.dart';

abstract class Newsstates {}
class Newsinitialstates extends Newsstates{}
class Newsloadingstates extends Newsstates{}
class Newsloadedstates extends Newsstates{
  final newsmodel newsModel;
  Newsloadedstates({required this.newsModel});
}
class Newserrorstates extends Newsstates{
  final String error;
  Newserrorstates({required this.error});
}