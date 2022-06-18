import 'package:crud/src/ui/ui.dart';
import 'package:crud/src/util/util.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({
    this.client,
    super.key,
    required this.onSave,
  });

  final Client? client;
  final Function(Client client) onSave;

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  late final TextEditingController _addressController;
  late final TextEditingController _emailController;
  late final TextEditingController _firstNameController;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController(
      text: widget.client?.address,
    );

    _emailController = TextEditingController(
      text: widget.client?.email,
    );

    _formKey = GlobalKey<FormState>();

    _firstNameController = TextEditingController(
      text: widget.client?.firstName,
    );

    _lastNameController = TextEditingController(
      text: widget.client?.lastName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500.0),
                border: Border.all(
                  width: 2.0,
                  color: AppColors.primaryColor,
                  style: BorderStyle.solid,
                ),
              ),
              height: 150.0,
              width: 150.0,
              padding: const EdgeInsets.all(
                Spacing.medium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 50.0,
                  ),
                  Text('Upload image'),
                ],
              ),
            ),
            const SizedBox(
              height: Spacing.small,
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(
                  Spacing.xsmall,
                ),
                labelText: 'First name*',
              ),
              validator: (value) {
                String? result;
                if (value?.isNotEmpty != true) {
                  result = 'Required value';
                }
                return result;
              },
            ),
            const SizedBox(
              height: Spacing.small,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(
                  Spacing.xsmall,
                ),
                labelText: 'Last name*',
              ),
              validator: (value) {
                String? result;
                if (value?.isNotEmpty != true) {
                  result = 'Required value';
                }
                return result;
              },
            ),
            const SizedBox(
              height: Spacing.small,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(
                  Spacing.xsmall,
                ),
                labelText: 'Email address*',
              ),
              validator: (value) => Validator.validateEmail(
                value,
              ),
            ),
            const SizedBox(
              height: Spacing.small,
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(
                  Spacing.xsmall,
                ),
                labelText: 'Address*',
              ),
              validator: (value) {
                String? result;
                if (value?.isNotEmpty != true) {
                  result = 'Required value';
                }
                return result;
              },
            ),
            const SizedBox(
              height: Spacing.medium,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    child: Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: MinimalElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final client = Client(
                          address: _addressController.text,
                          caption: widget.client?.caption ?? '',
                          email: _emailController.text,
                          firstName: _firstNameController.text,
                          id: widget.client?.id,
                          lastName: _lastNameController.text,
                          photo: widget.client?.photo ?? '',
                        );
                        widget.onSave(client);
                      }
                    },
                    label: 'SAVE',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
