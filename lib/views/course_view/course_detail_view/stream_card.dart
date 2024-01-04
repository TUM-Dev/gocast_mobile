import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class StreamCard extends StatelessWidget {
  final String imageName;
  final Stream stream;
  final VoidCallback onTap;

  const StreamCard({
    super.key,
    required this.imageName,
    required this.stream,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStreamInfo(stream.name, stream.description),
          _buildInternetImage(),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamInfo(String name, String description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternetImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        imageName,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/default_image.png',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

