import 'package:crud/src/core/core.dart';
import 'package:crud/src/features/features.dart';
import 'package:crud/src/ui/ui.dart';
import 'package:crud/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildBody(CreateUserViewModel viewModel) {
    Widget registerButton = MinimalElevatedButton(
      label: 'REGISTER',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.createUser(
            email: _emailController.text,
            password: _passwordController.text,
          );
        }
      },
    );

    if (viewModel.state == CreateUserViewState.loading) {
      registerButton = CircularProgressIndicator(
        color: AppColors.accentColor,
      );
    }

    if (viewModel.state == CreateUserViewState.error) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => DefaultDialog.showCustomDialog(
          context,
          title: 'An error has occurred',
          body: Text(viewModel.description!),
          actions: [
            MinimalElevatedButton(
              label: 'OK',
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }

    if (viewModel.state == CreateUserViewState.completed) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => DefaultDialog.showCustomDialog(
          context,
          title: 'Registration successful',
          body: Text(
            'The user ${viewModel.user.fullName} has registered successfully. Please go back an login with your credentials.',
          ),
          actions: [
            MinimalElevatedButton(
              label: 'OK',
              onPressed: () => Navigator.of(context).popUntil(
                ModalRoute.withName(NamedRoute.login),
              ),
            )
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.large * 2,
        vertical: Spacing.medium,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: Spacing.large * 4,
            ),
            Image.asset(
              AppImages.appLogo,
              fit: BoxFit.fitHeight,
              height: Spacing.large * 4,
            ),
            const SizedBox(
              height: Spacing.large,
            ),
            Text('REGISTER'),
            const SizedBox(
              height: Spacing.xlarge,
            ),
            MinimalTextFormField(
              controller: _emailController,
              label: 'Mail',
              validator: (value) => Validator.validateEmail(
                value,
              ),
            ),
            const SizedBox(
              height: Spacing.large,
            ),
            MinimalTextFormField(
              controller: _passwordController,
              label: 'Password',
              obscureText: true,
              validator: (value) => Validator.validatePassword(
                value,
              ),
            ),
            const SizedBox(
              height: Spacing.large,
            ),
            MinimalTextFormField(
              controller: _repeatPasswordController,
              label: 'Repeat Password',
              obscureText: true,
              validator: (value) => Validator.validateRepeatPassword(
                value,
                password: _passwordController.text,
              ),
            ),
            const SizedBox(
              height: Spacing.xlarge + Spacing.medium,
            ),
            registerButton,
            const SizedBox(
              height: Spacing.medium,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                primary: AppColors.accentColor,
              ),
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlurredBackground(
        color: AppColors.primaryColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ChangeNotifierProvider<CreateUserViewModel>(
            create: (_) => context.read<Injector>().createUserViewModel,
            child: Consumer<CreateUserViewModel>(
              builder: (_, viewModel, __) => _buildBody(viewModel),
            ),
          ),
        ),
      );
}
