import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
 // final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
   // @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/get2.jpg',
    title: 'Step into a New world of Messaging',
   // description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/guy.jpg',
    title: 'Meet New Friends',
   // description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/share.jpg',
    title: 'Share Moments',
    //description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/video.jpg',
    title: 'Video calls',
  //  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/meeting.jpg',
    title: 'Meetings',
    //description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
];