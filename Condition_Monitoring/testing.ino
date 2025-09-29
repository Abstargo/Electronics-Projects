#include <wire.h>
#include <LiquidCrystal_I2C.h>
#include <MPU6050.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

MPU6050 mpu;

const int ACS_PIN = 34;
const float ACS_VCC = 5.0;
const float ADC_RES = 4095.0;
const float V_REF = 3.3;


const float SENSITIVITY = 0.020;


float offsetVolatge = V_REF / 2;
float current = 0;
float accX, accY, accZ;


void setup()
{

	Serial.begin(115200);
	Wire.begin();


	lcd.init();
	lcd.backlight();
	lcd.setCursor(0, 0);
	lcd.print("System Init...");
	delay(1000);

	mpu.initialize();
	if (mpu.testConnection()){
		
		Serial.println("MPU6050 connected!");	
	} else {

		Serial.println("MPU6050 connection failed!");
	}
}

void loop()
{

	mpu.getAcceleration(&accX, &accY, &accZ);

	float ax = accX / 16384.0;
	float ay = accX / 16384.0;
	float az = accZ / 16384.0;

	int adcValue = analogRead(ACS_PIN);

	float voltage = (adcValue / ADC_RES) * V_REF;

	float sensorVoltage = voltage * (5.0 / 3.3);

	float current = (sensorVoltage - (ACS_VCC / 2)) / SENSITIVITY;


	Serial.print("Accel (g): X=");
	Serial.print(ax); Serial.print("Y=");
	Serial.print(ay); Serial.print("Z=");
	Serial.print(az);
	Serial.print(" | Current: ");
	Serial.print(current);
	Serial.println(" A");


	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("I=");
	lcd.print(current, 1);
	lcd.print("A");
}
