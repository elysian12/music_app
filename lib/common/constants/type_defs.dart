import 'package:fpdart/fpdart.dart';
import 'package:music_app/common/constants/faliure.dart';

typedef FutureEither<T> = Either<Failure, T>;
typedef FutureVoid = FutureEither<void>;
