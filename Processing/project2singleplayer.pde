import processing.serial.*;

Serial myPort;

int cursorX = 50, cursorY = 50;  
int thumbX, thumbY;              
int speed = 5;                   
int score = 0;                   
boolean gameStarted = false;     
boolean gameEnded = false;      
PImage thumbImage, cursorImage; 
int gameTime = 45000;  // 45 seconds
int startTime;        

// Data for heat map
int[][] grid = new int[10][10]; 

int thumbInterval = 2000;  
int lastThumbMove = 0;     

void setup() {
  size(600, 400);  
  myPort = new Serial(this, Serial.list()[4], 115200);  // verify the correct port and baud rate
  textSize(20);  
  frameRate(60); 
  thumbImage = loadImage("smiley-thumb.png");
  cursorImage = loadImage("cursor.png");

  resetThumb();  
}

void draw() {
  background(0);  

  if (gameEnded) {
    displayHeatmap();  
    checkRestart();  
    return;
  }

  if (gameStarted) {
    int elapsedTime = millis() - startTime;  

    if (elapsedTime >= gameTime) {
      gameStarted = false;  
      gameEnded = true;     
    }
  }

  if (myPort.available() > 0) {
    String data = myPort.readStringUntil('\n');  

    if (data != null) {
      String[] values = split(trim(data), ',');  

      if (values.length == 4) {
        try {
          int x = int(map(float(values[0]), 0, 100, 0, width));
          int y = int(map(float(values[1]), 0, 100, 0, height));
          int speedValue = int(values[2]);  
          int buttonPressed = int(values[3]);

          cursorX = x;
          cursorY = y;

          thumbInterval = int(map(speedValue, 1, 10, 2000, 300));  

          if (!gameStarted && !gameEnded && buttonPressed == 1) {
            startGame();  // Start the game
          }

          if (gameStarted && buttonPressed == 1 && dist(cursorX, cursorY, thumbX, thumbY) < 50) {
            score++;  
            updateHeatmap(thumbX, thumbY);  
            resetThumb();  

            fill(0, 255, 0, 100);
            rect(0, 0, width, height);
            delay(500);  
          }
        } catch (Exception e) {
          println("Error parsing data: " + e.getMessage());
        }
      }
    }
  }

  if (millis() - lastThumbMove >= thumbInterval && gameStarted) {
    resetThumb();  
    lastThumbMove = millis(); 
  }

  if (gameStarted) {
    image(thumbImage, thumbX, thumbY, 80, 80);
    image(cursorImage, cursorX, cursorY, 50, 50);

    if (dist(cursorX, cursorY, thumbX, thumbY) < 50) {
      fill(255, 255, 0, 100);  
      rect(0, 0, width, height);
    }

    fill(255);
    text("Score: " + score, 10, 30);
    int timeLeft = max(0, (gameTime - (millis() - startTime)) / 1000);
    text("Time Left: " + timeLeft + "s", 10, 60);
  } else if (!gameEnded) {
    fill(255);
    text("Press Joystick Button to Start", width / 2 - 150, height / 2);
  }
}

void resetThumb() {
  thumbX = int(random(20, width - 20));  
  thumbY = int(random(20, height - 20));  
}

void updateHeatmap(int x, int y) {
  int gridX = int(map(x, 0, width, 0, 9));  
  int gridY = int(map(y, 0, height, 0, 9));  

  gridX = constrain(gridX, 0, 9);
  gridY = constrain(gridY, 0, 9);

  grid[gridX][gridY]++;  
}

void displayHeatmap() {
  background(0);  

  fill(255);
  text("Game Over!", 10, 30);
  text("Final Score: " + score, 10, 60);

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      // Use exponential scaling to increase contrast
      float intensity = pow(grid[i][j] / float(max(1, score)), 0.5);  // Square root scaling
      int r = int(lerp(50, 255, intensity));  // From dark red to bright red
      int g = int(lerp(0, 255, intensity));   // Add green to get a yellowish gradient

      fill(r, g, 0);  // Color based on intensity
      rect(i * 60, j * 40, 60, 40);  // Draw each heatmap cell
    }
  }

  fill(255);
  text("Press Joystick Button to Restart", width / 2 - 150, height - 30);
}

void checkRestart() {
  if (gameEnded) {  // Only allow restart after the game has ended
    if (myPort.available() > 0) {
      String data = myPort.readStringUntil('\n');  

      if (data != null) {
        String[] values = split(trim(data), ',');  

        if (values.length == 4) {
          int buttonPressed = int(values[3]);

          if (buttonPressed == 1) {
            restartGame();  // Restart the game when the button is pressed
          }
        }
      }
    }
  }
}


void startGame() {
  gameStarted = true;
  gameEnded = false;
  score = 0;
  startTime = millis();  
  resetThumb();
  resetHeatmap();  // Clear the heatmap data
}

void restartGame() {
  gameEnded = false;  
  startGame();  
}

void resetHeatmap() {
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      grid[i][j] = 0;  
    }
  }
}
