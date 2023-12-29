import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class PinnedCourseCard extends StatelessWidget {
  final String imageName;
  final Course course;
  final bool isPinned;
  final VoidCallback onPinToggle;
  final VoidCallback onTap;

  const PinnedCourseCard({
    super.key,
    required this.imageName,
    required this.course,
    required this.isPinned,
    required this.onTap,
    required this.onPinToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        // Wrap Card with InkWell for click functionality
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${course.name} - ${course.slug}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "${course.semester.year} ${course.semester.teachingTerm}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                        color: Colors.blue[800],
                      ),
                      onPressed: onPinToggle,
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  imageName,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
