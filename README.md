# ThumbWarCreativeEmbSys

This project is an interactive thumb war game developed for the Creative Embedded Systems course. Utilizing the ESP32 TTGO T-display, a joystick, a button, and a potentiometer, the game engages users in a playful competition where they must catch a virtual thumb that appears randomly on the screen. Players earn points by successfully covering the thumb with a cursor controlled by the joystick, while the speed of the thumb's movement increases over time.

![Thumb-War1-ezgif com-optimize](https://github.com/user-attachments/assets/94145158-fb66-4b49-8d2c-1f26461ac01d)

## Design Goals

- **Nostalgic Experience**: To recreate the simple joy and excitement of the childhood game "thumb war" using modern technology, capturing the essence of quick reflexes and fun competition.
- **User Engagement**: Creating an interactive and visually appealing gameplay experience that keeps users engaged for the duration of the game.
- **Accessibility**: Ensuring that the game is easy to understand and play, making it accessible to users of all ages and skill levels.
- **Customizability**: Allowing players to adjust the difficulty of the game through the potentiometer, adding a layer of challenge as they improve.
- **Visual Feedback**: Implementing clear visual cues (like color changes) to enhance user interaction and enjoyment.

## Hardware Requirements

- ESP32 TTGO T-display
- Joystick module
- Potentiometer
- Push button
- Breadboard and jumper wires

## Software Requirements

- Arduino IDE
- Processing IDE
- ESP32 board package installed in Arduino IDE
- Libraries for graphics display on TTGO screen (TFT_eSPI)

  Here's is my Fritzing diagram representing how I connected my componenets to the breadboard.

  <img width="329" alt="Screenshot 2024-11-04 at 7 51 13 PM" src="https://github.com/user-attachments/assets/2d74d96e-be48-4e69-84c6-5c1796fedd8c">

## How to Run

1. Set up your ESP32 to connect it to your computer (Assuming you've connected your components already as demonstarted above
2. Run the Arduino code
3. Open processing and run the code there as well (make sure that you do not have the serial monitor from Arduino open)
4. A window will open with the gameplay
5. Yay! Play your heart out now

Check out my Medium Blog Post for more behind the scenes scoop on this project:
https://medium.com/@abg2193/i-do-declare-a-thumb-war-d195f5093243
