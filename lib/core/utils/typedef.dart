import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Type definition for result type using Either from dartz
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;
typedef DataMap = Map<String, dynamic>;

