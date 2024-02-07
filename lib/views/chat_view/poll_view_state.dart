import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/chat_view/poll_view.dart';

class PollViewState extends ConsumerState<PollView> {
  Timer? _updateTimer;
  Map<int, int> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  void _initializeTimer() {
    _updateTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      if (mounted && widget.streamID != null) {
        ref.read(pollViewModelProvider.notifier).fetchPolls(widget.streamID!);
      }
    });

    if (widget.streamID != null) {
      Future.microtask(() async {
        // Fetch the polls first
        await ref
            .read(pollViewModelProvider.notifier)
            .fetchPolls(widget.streamID!);
        ref.read(pollViewModelProvider.notifier).getAnsweredPolls();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final polls = ref
            .watch(pollViewModelProvider)
            .polls
            ?.where((poll) => poll.active)
            .toList() ??
        [];
    final answeredPolls = ref.watch(pollViewModelProvider).answeredPolls;

    return Scaffold(
      body: _buildPollsList(polls, answeredPolls),
    );
  }

  Widget _buildPollsList(List<Poll> polls, Map<int, int> answeredPolls) {
    return polls.isEmpty
        ? const Center(child: Text('No active polls'))
        : ListView.builder(
            itemCount: polls.length,
            itemBuilder: (context, index) =>
                _buildPollCard(context, polls[index], answeredPolls),
          );
  }

  Widget _buildPollCard(
    BuildContext context,
    Poll poll,
    Map<int, int> answeredPolls,
  ) {
    bool isAnswered = answeredPolls.containsKey(poll.id);
    return isAnswered
        ? _buildAnsweredPollCard(context, poll, answeredPolls[poll.id])
        : _buildUnansweredPollCard(context, poll);
  }

  Widget _buildAnsweredPollCard(
    BuildContext context,
    Poll poll,
    int? answeredOptionId,
  ) {
    ThemeData themeData = Theme.of(context);
    return Opacity(
      opacity: 0.5,
      child: Card(
        elevation: 1,
        shadowColor: themeData.shadowColor,
        color: themeData.cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: themeData
                    .inputDecorationTheme.enabledBorder?.borderSide.color
                    .withOpacity(0.2) ??
                Colors.grey.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: themeData.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPollQuestion(poll),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                  ),
                  itemCount: poll.pollOptions.length,
                  itemBuilder: (context, index) {
                    return _buildInactivePollOption(
                      context,
                      poll,
                      poll.pollOptions[index],
                      answeredOptionId,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInactivePollOption(
    BuildContext context,
    Poll poll,
    PollOption option,
    int? selectedOptionId,
  ) {
    bool isSelected = option.id == selectedOptionId;
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          option.answer,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildUnansweredPollCard(BuildContext context, Poll poll) {
    ThemeData themeData = Theme.of(context);
    return Card(
      elevation: 1,
      shadowColor: themeData.shadowColor,
      color: themeData.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: themeData.inputDecorationTheme.enabledBorder?.borderSide.color
                  .withOpacity(0.2) ??
              Colors.grey.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: themeData.cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPollQuestion(poll),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: poll.pollOptions.length,
                itemBuilder: (context, index) {
                  return _buildActivePollOption(
                    context,
                    poll,
                    poll.pollOptions[index],
                  );
                },
              ),
              _buildSubmitButton(poll),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivePollOption(
    BuildContext context,
    Poll poll,
    PollOption option,
  ) {
    bool isSelected = selectedOptions[poll.id] == option.id;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptions[poll.id] = option.id;
        });
      },
      child: Container(
        margin:
            const EdgeInsets.all(4.0), // Add some spacing around each button
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          // Change color based on selection
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        ),
        child: Center(
          child: Text(
            option.answer,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.black, // Change text color based on selection
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPollQuestion(Poll poll) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              poll.question,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(Poll poll) {
    final pollViewModel = ref.read(pollViewModelProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ), // Consistent padding with the rest of the layout
      child: ElevatedButton(
        onPressed: selectedOptions.containsKey(poll.id)
            ? () {
                final int? pollOptionId = selectedOptions[poll.id];
                if (pollOptionId != null) {
                  setState(() {
                    pollViewModel.postPollVote(poll.streamID, pollOptionId);
                    pollViewModel.postAnsweredPoll(poll.id, pollOptionId);
                  });
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 30.0),
          minimumSize: const Size(double.infinity, 48),
          elevation: 2,
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
