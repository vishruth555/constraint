import 'dart:math';
import 'dart:ui';

const color1 = Color.fromRGBO(158, 200, 185, 1); //light blue
const color2 = Color.fromRGBO(9, 38, 53, 0.95); //dark blue
const color3 = Color.fromRGBO(27, 66, 66, 1); //dark green
const color4 = Color.fromRGBO(92, 131, 116, 1); //light green

const basic1 = Color.fromRGBO(255, 255, 255, 1); //white

Color randomColor() {
  // Function to generate random colors
  return Color.fromRGBO(
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
    1.0,
  );
}
