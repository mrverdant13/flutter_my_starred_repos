part of 'screen.dart';

extension _InternationalizedContext on BuildContext {
  String get loginButtonLabel => l10n.loginButtonLabel;

  String get loginCanceledMessage => l10n.loginCanceledMessage;
  String get missingLoginPermissionsMessage =>
      l10n.missingLoginPermissionsMessage;
  String get loginOfflineMessage => l10n.loginOfflineMessage;
  String get loginUnexpectedMessage => l10n.loginUnexpectedMessage;
}
