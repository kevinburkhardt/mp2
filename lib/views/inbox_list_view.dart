import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/inbox_viewmodel.dart';
import '../widgets/message_preview_tile.dart';
import 'message_detail_view.dart';

class InboxListView extends StatefulWidget {
  const InboxListView({super.key});

  @override
  State<InboxListView> createState() => _InboxListViewState();
}

class _InboxListViewState extends State<InboxListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load data when view first appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InboxViewmodel>().loadInbox();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<InboxViewmodel>(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final searchBar = CupertinoSearchTextField(
      controller: _searchController,
      placeholder: 'Search',
    );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: const Text('Inbox'),
        trailing: isLandscape ? SizedBox(width: 200, child: searchBar) : null,
      ),
      child: SafeArea(
        child: vm.isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : (isLandscape && vm.selectedMessage != null)
            ? Row(
                children: [
                  Flexible(flex: 1, child: _buildMessageList(context, vm)),
                  const VerticalDivider(
                    width: 1,
                    color: CupertinoColors.systemGrey4,
                  ),
                  Flexible(
                    flex: 1,
                    child: vm.selectedMessage == null
                        ? const Center(child: Text("Select a message"))
                        : MessageDetailView(message: vm.selectedMessage),
                  ),
                ],
              )
            : Column(
                children: [
                  if (!isLandscape)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: searchBar,
                    ),
                  Expanded(child: _buildMessageList(context, vm)),
                ],
              ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context, InboxViewmodel vm) {
    // combine all message types into a single list
    final items = vm.allMessages;

    if (items.isEmpty) {
      return const Center(child: Text("No messages found"));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return MessagePreviewTile(
          item: item,
          onTap: () {
            vm.selectMessage(item);
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => MessageDetailView(message: item),
                ),
              );
            }
          },
        );
      },
    );
  }
}
