import 'package:crud/src/core/core.dart';
import 'package:crud/src/features/features.dart';
import 'package:crud/src/ui/ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<Injector>().homeViewModel;
  }

  Widget _buildBody(BuildContext context) {
    Widget body = Center(
      child: CircularProgressIndicator(
        color: AppColors.accentColor,
      ),
    );

    if (_viewModel.state == HomeViewState.initial) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => _viewModel.fetchClients(),
      );
    }

    if (_viewModel.state == HomeViewState.error) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => DefaultDialog.showCustomDialog(
          context,
          title: 'An error has occurred',
          body: Text(_viewModel.description!),
          actions: [
            MinimalElevatedButton(
              label: 'OK',
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }

    if (_viewModel.state == HomeViewState.completed) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Spacing.medium,
                    ),
                    fillColor: AppColors.accentColor,
                    hintText: 'Search...',
                  ),
                ),
              ),
              const SizedBox(width: Spacing.medium),
              MinimalElevatedButton(
                height: Spacing.xlarge,
                label: 'ADD NEW',
                onPressed: () => _showClientDataDialog(context),
                width: Spacing.large * 4,
              ),
            ],
          ),
          const SizedBox(
            height: Spacing.medium,
          ),
          Text(
            'CLIENTS',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            height: Spacing.medium,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _viewModel.clients.length,
              separatorBuilder: (_, __) => const SizedBox(
                height: Spacing.medium,
              ),
              itemBuilder: (context, index) => ClientCard(
                client: _viewModel.clients[index],
                onDelete: (int clientId) => _showDeleteConfirmationDialog(
                  context,
                  clientId: clientId,
                ),
                onEdit: (Client client) => _showClientDataDialog(
                  context,
                  client: client,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Spacing.small,
          ),
          MinimalElevatedButton(
            label: 'LOAD MORE',
            onPressed: _viewModel.isMoreDataAvailable
                ? () => _viewModel.fetchClients()
                : null,
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.xlarge,
        vertical: Spacing.medium,
      ),
      child: body,
    );
  }

  void _showClientDataDialog(
    context, {
    Client? client,
  }) {
    DefaultDialog.showCustomDialog(
      context,
      title: 'Add new client',
      body: ClientForm(
        client: client,
        onSave: (client) {
          Navigator.of(context).pop();
          _viewModel.saveClient(client);
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context, {
    required int clientId,
  }) {
    DefaultDialog.showCustomDialog(
      context,
      title: 'Delete confirmation',
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Are you sure you want to delete de selected client?'),
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
                  label: 'DELETE',
                  onPressed: () {
                    Navigator.of(context).pop();
                    _viewModel.deleteClient(
                      clientId,
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlurredBackground(
      color: AppColors.primaryColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Image.asset(
            AppImages.appLogo,
            fit: BoxFit.fitHeight,
            height: Spacing.large * 2,
          ),
        ),
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (_) => _viewModel,
          child: Consumer<HomeViewModel>(
            builder: (_, viewModel, __) => _buildBody(context),
          ),
        ),
      ),
    );
  }
}
