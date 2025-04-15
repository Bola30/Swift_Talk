import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'swift_state_state.dart';

class SwiftStateCubit extends Cubit<SwiftStateState> {
  SwiftStateCubit() : super(SwiftStateInitial());
}
