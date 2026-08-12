import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SubjectResultCard extends StatelessWidget {
  final int duration;
  final int numberOfQuestions;
  final int? numOfCorrectAnswers;
  final String? takenTime;
  final String examTitle;
  final String image;
  final VoidCallback onTap;

  const SubjectResultCard({
    super.key,
    required this.duration,
    required this.numberOfQuestions,
    this.numOfCorrectAnswers,
    this.takenTime,
    required this.examTitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(121, 201, 201, 201)),
          boxShadow: [
            BoxShadow(color: Color.fromARGB(51, 5, 5, 5), blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            Image.network(image, width: 60, height: 60),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        examTitle,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "exam_duration".tr(
                          namedArgs: {"duration": duration.toString()},
                        ),
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "exam_questions".tr(
                      namedArgs: {"count": numberOfQuestions.toString()},
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 15),
                  if (numOfCorrectAnswers != null && takenTime != null) ...[
                    Text(
                      "exam_result_summary".tr(
                        namedArgs: {
                          "correct": numOfCorrectAnswers.toString(),
                          "time": takenTime!,
                        },
                      ),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
