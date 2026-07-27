import 'package:flutter/material.dart';

class TimeOutDialog extends StatelessWidget {
  final VoidCallback onViewScore;

  const TimeOutDialog({super.key, required this.onViewScore});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://media.istockphoto.com/id/1180957698/photo/hourglass-on-white-background-sandglass.jpg?s=1024x1024&w=is&k=20&c=clrs7k2rbrWfZ8BvGi7mi0T6NA2nelQ9WLhKp8Iy8iQ=",
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 16),
                const Text(
                  "Time out !!",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onViewScore,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: const StadiumBorder(),
                ),
                child: const Text("View score", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
