import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class EncodeAndDecodeBase64 {
  
  imageToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  Base64ToImage(String stringBase64) {    
    return base64Decode(stringBase64);
  }
}
