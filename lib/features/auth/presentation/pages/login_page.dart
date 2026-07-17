import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/auth/auth_controller.dart' as core_auth;
import '../../../../core/state/view_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/ui/atoms/app_button.dart';
import '../../../../shared/ui/atoms/inline_error_text.dart';
import '../../../../shared/ui/templates/detail_template.dart';
import '../../../auth/presentation/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        final loading = controller.state.status == ViewStatus.loading;
        final message = controller.state.message == 'LOGIN_INVALID_SESSION'
            ? l10n.loginInvalidSession
            : controller.state.message;
        return DetailTemplate(
          title: l10n.loginTitle,
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: l10n.loginEmail),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.commonRequired;
                    }
                    if (!value.contains('@')) {
                      return l10n.loginInvalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: l10n.loginPassword),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.commonRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                InlineErrorText(message),
              ],
            ),
          ),
          actions: [
            AppButton(
              label: loading ? l10n.loginSubmitting : l10n.loginSubmit,
              onPressed: loading
                  ? null
                  : () async {
                      if (_formKey.currentState?.validate() != true) {
                        return;
                      }

                      await controller.login(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                      );

                      if (!context.mounted) return;

                      if (controller.state.status == ViewStatus.success) {
                        final auth = context.read<core_auth.AuthController>();
                        final (nextRoute, nextArgs) = auth.consumePendingRoute();
                        Navigator.of(context).pushReplacementNamed(
                          nextRoute ?? '/',
                          arguments: nextArgs,
                        );
                      }
                    },
            ),
          ],
        );
      },
    );
  }
}
