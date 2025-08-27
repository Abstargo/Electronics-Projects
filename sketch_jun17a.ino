#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <SoftwareSerial.h>
#include <DFRobotDFPlayerMini.h>
#include <MPU6050.h>

MPU6050 mpu;
LiquidCrystal_I2C lcd(0x27, 16, 2);
SoftwareSerial mySoftwareSerial(10, 11); // RX, TX
DFRobotDFPlayerMini myDFPlayer;

const int greenLed = 2;
const int yellowLed = 3;
const int redLed = 4;

const float lowThreshold = 0.05;
const float mediumThreshold = 0.08;
const float highThreshold = 0.17;
const float peakThreshold = 0.05;

const int windowSize = 10;
float magnitudeBuffer[windowSize];
int bufferIndex = 0;

bool wasAbove = false;
unsigned long lastPeakTime = 0;
float frequency = 0;

int highReadingCount = 0;
const int detectionThreshold = 3;
const unsigned long alarmDelay = 4000;
const unsigned long audioLength = 40000;
unsigned long strongStartTime = 0;
bool alarmTriggered = false;

String lastStatus = "";
float lastFreq = 0;

void setup() {
  Serial.begin(115200);

  pinMode(greenLed, OUTPUT);
  pinMode(yellowLed, OUTPUT);
  pinMode(redLed, OUTPUT);

  // Turn all LEDs off initially
  digitalWrite(greenLed, LOW);
  digitalWrite(yellowLed, LOW);
  digitalWrite(redLed, LOW);

  lcd.init();
  lcd.backlight();
  lcd.print("Initializing...");

  Wire.begin();
  mpu.initialize();
  mpu.setFullScaleAccelRange(MPU6050_ACCEL_FS_2);

  if (!mpu.testConnection()) {
    lcd.clear();
    lcd.print("MPU6050 Error!");
    while (1);
  }

  mySoftwareSerial.begin(9600);
  if (!myDFPlayer.begin(mySoftwareSerial)) {
    lcd.clear();
    lcd.print("DFPlayer Error!");
    while (1);
  }
  myDFPlayer.volume(20);

  // Fill buffer with 0s and wait to stabilize
  for (int i = 0; i < windowSize; i++) magnitudeBuffer[i] = 0;
  delay(1000);  // Give sensor some time to stabilize

  lcd.clear();
}

void loop() {
  int16_t ax, ay, az;
  mpu.getAcceleration(&ax, &ay, &az);

  float ax_g = ax / 16384.0;
  float ay_g = ay / 16384.0;
  float az_g = az / 16384.0;

  float rawMagnitude = sqrt(sq(ax_g) + sq(ay_g) + sq(az_g)) - 1.0;
  rawMagnitude = abs(rawMagnitude);
  rawMagnitude = constrain(rawMagnitude, 0, 2.0);

  magnitudeBuffer[bufferIndex] = rawMagnitude;
  bufferIndex = (bufferIndex + 1) % windowSize;

  float smoothedMagnitude = 0;
  for (int i = 0; i < windowSize; i++) smoothedMagnitude += magnitudeBuffer[i];
  smoothedMagnitude /= windowSize;

  // Frequency Detection
  if (!wasAbove && rawMagnitude > peakThreshold) {
    wasAbove = true;
    unsigned long currentTime = millis();
    unsigned long period = currentTime - lastPeakTime;
    if (period > 10 && period < 2000) {
      frequency = 1000.0 / period;
    }
    lastPeakTime = currentTime;
  } else if (wasAbove && rawMagnitude < peakThreshold) {
    wasAbove = false;
  }

  detectEarthquake(smoothedMagnitude, frequency);

  Serial.print(smoothedMagnitude, 6);
  Serial.print(",");
  Serial.println(frequency, 2);

  delay(20);  // ~50Hz sampling
}

void detectEarthquake(float magnitude, float freq) {
  unsigned long currentTime = millis();
  String status;

  if (alarmTriggered && (currentTime - strongStartTime < audioLength)) {
    status = "ALARM!";
    digitalWrite(greenLed, LOW);
    digitalWrite(yellowLed, LOW);
    digitalWrite(redLed, HIGH);
  } else {
    if (alarmTriggered && (currentTime - strongStartTime >= audioLength)) {
      alarmTriggered = false;
      highReadingCount = 0;
    }

    if (magnitude < lowThreshold) {
      status = "Safe"; 
      digitalWrite(greenLed, HIGH);
      digitalWrite(yellowLed, LOW);
      digitalWrite(redLed, LOW);
      highReadingCount = 0;
    } else if (magnitude < highThreshold) {
      status = "Medium";
      digitalWrite(greenLed, LOW);
      digitalWrite(yellowLed, HIGH);
      digitalWrite(redLed, LOW);
      highReadingCount = 0;
    } else {
      status = "Danger";
      digitalWrite(greenLed, LOW);
      digitalWrite(yellowLed, LOW);
      digitalWrite(redLed, HIGH);
      highReadingCount++;

      if (highReadingCount >= detectionThreshold && !alarmTriggered) {
        if (strongStartTime == 0) strongStartTime = currentTime;
        if (currentTime - strongStartTime >= alarmDelay) {
          myDFPlayer.play(1);
          alarmTriggered = true;
          strongStartTime = currentTime;
          Serial.println(">>> Alarm triggered");
        }
      }
    }
  }

  updateLCD(status, freq);
}

void updateLCD(String status, float freq) {
  if (status != lastStatus || abs(freq - lastFreq) > 0.1) {
    lcd.setCursor(0, 0);
    lcd.print("Etat: " + status + "    ");
    lcd.setCursor(0, 1);
    lcd.print("Freq: ");
    lcd.print(freq, 1);
    lcd.print("Hz     ");
    lastStatus = status;
    lastFreq = freq;
  }
}
