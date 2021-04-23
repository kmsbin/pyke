import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum RegisterEvent { loading, done, error, waiting }

class RegisterBloc extends BlocBase {
  RegisterEvent registerState = RegisterEvent.waiting;

  BehaviorSubject _controller = BehaviorSubject();

  Sink get input => _controller.sink;
  Stream get output => _controller.stream;
  RegisterBloc() {
    mapEventToState(registerState);
  }

  mapEventToState(RegisterEvent registerEvent) {
    output.listen((event) {
      if (registerEvent == RegisterEvent.done) {}
      if (registerEvent == RegisterEvent.error) {}
      if (registerEvent == RegisterEvent.waiting) {}
      if (registerEvent == RegisterEvent.loading) {}
    });
  }
}
