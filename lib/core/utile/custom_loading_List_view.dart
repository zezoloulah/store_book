import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomLoadingListView extends StatelessWidget {
  const CustomLoadingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * 0.85,
      child: Shimmer(
        color: Colors.black,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, count) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                
                height: h * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}