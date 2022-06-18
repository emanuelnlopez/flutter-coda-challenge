import 'package:crud/src/ui/ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({
    required this.client,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  final Client client;
  final Function(int clientId) onDelete;
  final Function(Client client) onEdit;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.small,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.accentColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        child: ListTile(
          leading: _buildProfileIcon(),
          subtitle: Text(client.email),
          title: Text(client.fullName),
          trailing: _buildContextualMenu(),
        ),
      );

  Widget _buildProfileIcon() {
    final child = client.photo.isNotEmpty
        ? Image.network(
            client.photo,
            fit: BoxFit.cover,
            height: 50.0,
            width: 50.0,
          )
        : Container(
            height: 50.0,
            width: 50.0,
            color: AppColors.accentColor,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 40.0,
            ),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(500.0),
      child: child,
    );
  }

  Widget _buildContextualMenu() => PopupMenuButton<MenuItem>(
        onSelected: (MenuItem item) => item.onPressed(),
        icon: Icon(
          Icons.more_vert,
          color: AppColors.accentColor,
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
          PopupMenuItem<MenuItem>(
            value: MenuItem(
              onPressed: () => onEdit(client),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: AppColors.accentColor,
                ),
                const SizedBox(
                  width: Spacing.xsmall,
                ),
                Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem<MenuItem>(
            value: MenuItem(
              onPressed: () => onDelete(client.id!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: AppColors.accentColor,
                ),
                const SizedBox(
                  width: Spacing.xsmall,
                ),
                Text('Delete'),
              ],
            ),
          ),
        ],
      );
}

class MenuItem {
  MenuItem({
    required this.onPressed,
  });

  final VoidCallback onPressed;
}
