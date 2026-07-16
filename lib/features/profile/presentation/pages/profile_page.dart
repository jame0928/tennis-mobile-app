import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/view_state.dart';
import '../../../../shared/ui/atoms/app_button.dart';
import '../../../../shared/ui/atoms/inline_error_text.dart';
import '../../../../shared/ui/atoms/skeleton_box.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../domain/entities/profile.dart';
import '../profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileController>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, controller, _) {
        final state = controller.state;
        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: switch (state.status) {
              ViewStatus.loading => const Column(
                children: [
                  SkeletonBox(height: 24),
                  SizedBox(height: 12),
                  SkeletonBox(height: 24),
                ],
              ),
              ViewStatus.failure => ErrorStateCard(
                message: state.message ?? 'Error loading profile',
                requestId: state.requestId,
                onRetry: controller.load,
              ),
              ViewStatus.success ||
              ViewStatus.paginating => _buildForm(controller, state.data!),
              _ => const SizedBox.shrink(),
            },
          ),
        );
      },
    );
  }

  Widget _buildForm(ProfileController controller, Profile profile) {
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _displayNameController.text = profile.displayName ?? '';
    _phoneController.text = profile.phone ?? '';

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First name'),
            validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last name'),
            validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _displayNameController,
            decoration: const InputDecoration(labelText: 'Display name'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          InlineErrorText(controller.state.message),
          const SizedBox(height: 16),
          AppButton(
            label: 'Save profile',
            onPressed: () {
              if (_formKey.currentState?.validate() != true) return;
              controller.save(
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
                displayName: _displayNameController.text.trim(),
                phone: _phoneController.text.trim(),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile update requested')),
              );
            },
          ),
        ],
      ),
    );
  }
}
