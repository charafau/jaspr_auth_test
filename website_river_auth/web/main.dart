// The entrypoint for the **client** environment.
//
// This file is compiled to javascript and executed in the browser.

// Client-specific jaspr import.
import 'package:jaspr/browser.dart';
import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_riverpod/misc.dart';
// Imports the [App] component.
import 'package:website_river_auth/app.dart';
import 'package:website_river_auth/login/jaspr_authentication_key_manager.dart';
import 'package:website_river_auth/login/jaspr_serverpod_session_manager.dart';
import 'package:website_river_auth/providers/client_provider.dart';

late final Client client;

late String serverUrl;

late final JasprServerpodSessionManager sessionManager;

Future<void> main() async {
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrl =
      serverUrlFromEnv.isEmpty ? 'http://localhost:8080/' : serverUrlFromEnv;

  client = Client(
    serverUrl,
    authenticationKeyManager: JasprAuthenticationKeyManager(),
  );

  sessionManager = JasprServerpodSessionManager(caller: client.modules.auth);
  await sessionManager.initialize();

  // Attaches the [App] component to the <body> of the page.
  runApp(ProviderScope(
    overrides: <Override>[
      clientProvider.overrideWith(
        (ref) => client,
      ),
    ],
    child: App(),
  ));
}
