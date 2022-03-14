import 'package:flutter/material.dart';

// Add your Google Maps API Key here
const String googleAPIKey = 'AIzaSyBX5G9F4fN-NxZ3SmKxEQXT9SWXpMhqOlU';

const EdgeInsets pagePadding = EdgeInsets.fromLTRB(15, 15, 15, 15);

enum SavedKeys{
  isVacant,
  washlet,
  multipurpose,
  madeYear,
  notRecyclePaper,
  doublePaper,
  seatWarmer,
  favToilets,
}

const keyString=<SavedKeys, String>{
  SavedKeys.isVacant:'isVacant',
  SavedKeys.washlet:'washlet',
  SavedKeys.madeYear:'madeYear',
  SavedKeys.notRecyclePaper:'notRecyclePaper',
  SavedKeys.doublePaper:'doublePaper',
  SavedKeys.seatWarmer:'seatWarmer',
  SavedKeys.favToilets:'favToilets',
}
