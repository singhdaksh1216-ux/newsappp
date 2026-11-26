import 'Newsmodel.dart';

abstract class NewsState{}
class NewInitialState extends NewsState{}
class NewLoadingState extends NewsState{}
class NewLoadedState extends NewsState{
  final Newsmodal NewsModal;
  NewLoadedState({required this.NewsModal});
}
class NewErrorState extends NewsState{
  final String error;
  NewErrorState({required this.error});
}