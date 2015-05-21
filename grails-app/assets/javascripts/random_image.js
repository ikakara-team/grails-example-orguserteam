"use strict";

function SelectRandomImage() {
  // Select a random thumbnail to display
  var imageList = [
    '<img src="' + appContext + '/assets/devoops/8962691008_7f489395c9_m.jpg" alt="Image 1" />',
    '<img src="' + appContext + '/assets/devoops/8985207189_01ea27882d_m.jpg" alt="Image 2" />',
    '<img src="' + appContext + '/assets/devoops/9036958611_fa1bb7f827_m.jpg" alt="Image 3" />',
    '<img src="' + appContext + '/assets/devoops/9041440555_2175b32078_m.jpg" alt="Image 4" />',
  ];

  return imageList[Math.floor(Math.random() * imageList.length)];
}