import 'package:flutter/material.dart';

class CardWidget {
  static basicCard({
    String? title,
    String? subTitle,
    IconData? icon,
    Color? color,
    Function()? onTapItem,
  }) {
    return InkWell(
      onTap: onTapItem,
      child: SizedBox(
        height: 80,
        child: Card(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              Icon(icon ?? Icons.home, size: 45, color: color ?? Colors.black),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    title ?? 'title',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subTitle ?? 'subTitle',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 30, color: Colors.black),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}