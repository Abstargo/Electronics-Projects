#include <wire.h>
#include <LiquidCrystal_I2C.h>
#include <max6675.h>


const int thermoSO = 19;
const int thermoCS = 5;
const int thermoSCK = 18;


const int SDA_PIN = 21;
const int SCL_PIN = 22;

MAX6675 thermocouple(thermoSO, thermoCS, thermoSCK);
LiquidCrystal_I2C lcd(0x27, 16, 2);

void setup()
{

	Serial.begin(115200);
	delay(500);

	wire.begin(SDA_PIN, SCL_PIN);
	
	lcd.init();
	lcd.backlight();
	lcd.clear();
	lcd.setCursor(0, 0);
	lcd.print("MAX6675 Test");
	delay(2000);
	lcd.clear();

	lcd.println("MAX6675 Thermocouple Test starting...");	
}


void loop()
{

	double tempC = thermocouple.readCelsius();
	double tempF = tempC * 9.0 / 5.0 + 32.0;

	lcd.setCursor(0, 0);
	lcd.print("Temp: ");
	lcd.print(tempC, 2);
	lcd.print((char)223);
	lcd.print("C ");

	lcd.setCursor(0, 1);
	lcd.print("Temp: ");
	lcd.print(tempF, 2);
	lcd.print((char)223);
	lcd.print("F  ");

	
	Serial.print("Temperature: ");
	Serial.print(tempC, 2);
	Serial.println(tempC, 2);

	delay(1000);
}




















