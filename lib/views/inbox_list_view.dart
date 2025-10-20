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
    final vm = context.watch<InboxViewmodel>();

    if (vm.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final allMessages = [...vm.memos, ...vm.events, ...vm.tasks];

    return Scaffold(
      appBar: AppBar(title: const Text('Inbox'), centerTitle: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: 'Search messages...',
              onChanged: (value) {
                // not implementing actual search yet
                print('User typed: $value');
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: allMessages.length,
              itemBuilder: (context, index) {
                final item = allMessages[index];
                return MessagePreviewTile(
                  item: item,
                  onTap: () {
                    print("Clicked $item");
                    // vm.selectMessage(item);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const MessageDetailView(),
                    //   ),
                    // );
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black, // solid black line
                thickness: 1.0, // line thickness
                height: 0, // no extra spacing
              ),
            ),
          ),
        ],
      ),
    );
  }
}
