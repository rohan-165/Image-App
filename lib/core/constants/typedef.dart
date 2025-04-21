import 'package:dartz/dartz.dart';
import 'package:demoproject/core/common/failure_state.dart';

typedef GestureTapCallback = void Function();
typedef VoidCallback = void Function()?;
typedef VoidCallbackWithValue<T> = void Function(T? value)?;

typedef FutureDynamicResponse = Future<Either<dynamic, Failure>>;
typedef DynamicResponse = Either<dynamic, Failure>;
