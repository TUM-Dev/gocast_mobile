import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/chat_view/poll_view.dart';

class PollViewState extends ConsumerState<PollView> {
  Timer? _updateTimer;
  final Map<int, int> _selectedOptions = {};
  final Set<int> _submittedPolls = {};

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
    _updateTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted && widget.streamID != null) {
        ref.read(pollViewModelProvider.notifier).fetchPolls(widget.streamID!);
      }
    });

    if (widget.streamID != null) {
      Future.microtask(() => ref
          .read(pollViewModelProvider.notifier)
          .fetchPolls(widget.streamID!));
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
    return Scaffold(
      body: _buildPollsList(polls),
    );
  }

  Widget _buildPollsList(List<Poll> polls) {
    return polls.isEmpty
        ? const Center(child: Text('No active polls'))
        : ListView.builder(
            itemCount: polls.length,
            itemBuilder: (context, index) =>
                _buildPollCard(context, polls[index]),
          );
  }

  Widget _buildPollCard(BuildContext context, Poll poll) {
    bool isSubmitted = _submittedPolls.contains(poll.id);
    return Opacity(
      opacity: isSubmitted ? 0.5 : 1,
      // Make the card semi-transparent if submitted
      child: Card(
        margin: const EdgeInsets.all(8.0),
        color: isSubmitted ? Colors.grey.shade200 : null,
        // Change background if submitted
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPollQuestion(poll),
            ...poll.pollOptions
                .map((option) => _buildPollOption(context, poll, option)),
            _buildSubmitButton(poll),
          ],
        ),
      ),
    );
  }

  Widget _buildPollQuestion(Poll poll) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        poll.question,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPollOption(BuildContext context, Poll poll, PollOption option) {
    bool isSubmitted = _submittedPolls.contains(poll.id);
    return ListTile(
      title: Text(option.answer),
      leading: Radio<int>(
        value: option.id,
        groupValue: _selectedOptions[poll.id],
        onChanged: isSubmitted
            ? null
            : (int? value) {
                // Disable if submitted
                setState(() {
                  _selectedOptions[poll.id] = value!;
                });
              },
      ),
    );
  }

  Widget _buildSubmitButton(Poll poll) {
    bool isSubmitted = _submittedPolls.contains(poll.id);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: !isSubmitted && _selectedOptions.containsKey(poll.id)
            ? () {
                // Add poll to submitted set
                setState(() {
                  _submittedPolls.add(poll.id);
                });

                ref
                    .read(pollViewModelProvider.notifier)
                    .postPollVote(poll.streamID, _selectedOptions[poll.id]!);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSubmitted
              ? Colors.grey
              : null, // Change color to grey if submitted
        ),
        child: Text(isSubmitted ? 'Submitted' : 'Submit'),
      ),
    );
  }
}
