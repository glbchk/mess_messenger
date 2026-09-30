import 'package:flutter/material.dart';

class ChatRequestPanelWidget extends StatelessWidget {
  final bool isRequester;
  final String peerName;
  final VoidCallback onAccept;
  final VoidCallback onBlock;
  final VoidCallback onIgnore;

  const ChatRequestPanelWidget({
    super.key,
    required this.isRequester,
    required this.peerName,
    required this.onAccept,
    required this.onBlock,
    required this.onIgnore,
  });

  @override
  Widget build(BuildContext context) {
    if (isRequester) {
      return Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text('Request sent — waiting for $peerName to accept'),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$peerName wants to send you a message'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: onIgnore, child: const Text('Ignore')),
              TextButton(onPressed: onBlock, child: const Text('Block')),
              ElevatedButton(onPressed: onAccept, child: const Text('Accept')),
            ],
          ),
        ],
      ),
    );
  }
}
