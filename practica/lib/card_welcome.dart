import 'package:flutter/material.dart';

import 'responsive.dart';

class CardWelcomeData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;
  final Widget child;

  const CardWelcomeData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.child,
    this.background,
  });
}

class CardWelcome extends StatelessWidget {
  const CardWelcome({required this.data, Key? key}) : super(key: key);

  final CardWelcomeData data;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Stack(
        children: [
          if (data.background != null) data.background!,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 100,
            ),
            child: Center(
              child: Column(
                children: [
                  Flexible(
                    flex: 20,
                    child: ImageCard(data: data),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    data.title.toUpperCase(),
                    style: TextStyle(
                        color: data.titleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                    maxLines: 1,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      color: data.subtitleColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                ],
              ),
            ),
          ),
          data.child,
        ],
      ),
      desktop: Stack(
        children: [
          if (data.background != null) data.background!,
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ImageCard(data: data),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.title.toUpperCase(),
                        style: TextStyle(
                            color: data.titleColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.subtitle,
                        style: TextStyle(
                          color: data.subtitleColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          data.child,
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.data,
  });

  final CardWelcomeData data;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image(
        image: data.image,
        width: 300,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
