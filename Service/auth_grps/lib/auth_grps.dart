import 'dart:async';
import 'dart:developer';

import 'package:auth_grps/domain/auth_rpc.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(
    () async {
      final authServer = Server.create(
        services: [AuthRpc()],
        interceptors: <Interceptor>[],
        codecRegistry: CodecRegistry(codecs: [GzipCodec()]),
      );
      await authServer.serve(port: 4400);
      log("Server listen port ${authServer.port}");
    },
    (error, stack) {
      log("Error", error: error);
    },
  );
}
