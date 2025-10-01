#include <wire.h>
#include <LiquidCrystal_I2C.h>
#include <MPU6050.h>
#include <max6675.h>


#define MAX6675_SCK 18
#define MAX6675_CS 5
#define MAX6675_SO 19

#define ACS_PIN 34

LiquidCrystal_I2C lcd(0x27, 16, 2);
MPU6050 mpu;
MAX6675 thermocouple(MAX6675_SCK, MAX6675_CS, MAX6675_SO);

const float R1 = 3900.0f;
const float R2 = 1000.0f;
const float ADC_MAX = 4095.0f;
const float V_REF = 3.3f;

const float ACS_VCC = 5.0f;
const float SENSITIVITY = 0.01f;

float Vzero_measured = 0.0f;
int baselineADC = 0;

float currentFiltered = 0.0f;
const float alpha = 0.2f;

void setup()
{

	Serial.begin(115200);
	wire.begin();
	lcd.init();
	lcd.backlight();
	lcd.clear();
	lcd.setCursor();
	lcd.print("Hello User...");
	

	mpu.initialize();
	if(!mpu.testConnection())
	{
	
		Serial.println("MPU6050 NOT connected!");
		lcd.setCursor(0, 1);
		lcd.print("MPU fail");
	} else {

		Serial.println("MPU6050 OK");
	}

	analogSetPinAttenuation(ACS_PIN, ADC_11db);


	long sum = 0;
	const int samples = 200;
	delay(200);
	for (int i = 0; i < samples; ++i)
	{

		sum += analogRead(ACS_PIN);
		delay(5);
	}
	baselineADC = sum / samples;

	float Vadc_baseline = ( (float)baselineADC / ADC_MAX ) * V_REF;

	Vzero_measured = Vadc_baseline * ( (R1 + R2) / R2);
	

	Serial.print("baselineADC = "); Serial.println(baselineADC);
	Serial.print("Vadc_baseline = "); Serial.println(Vadc_baseline, 4);
	Serial.print("Vzero_measured = "); Serial.println(Vzero_measured, 4);
	lcd.clear();
	lcd.setCursor(0, 0);
	lcd.print(" DONEE ");
	delay(800);


}

void loop()
{

	double tempC = thermocouple.readCelsius();
	if (isnan(tempC))
	{

		Serial.println(" T error (no TC)");
		tempC = -273.0;
	}

	int16_t ax_raw, ay_raw, az_raw;
	mpu.getAcceleration(&ax_raw, &ay_raw, &az_raw);
	
	float ax_g = (float)ax_raw / 16384.0f;
	float ay_g = (float)ay_raw / 16384.0f;
	float az_g = (float)az_raw / 16384.0f;

	float acc_mag_g = sqrt(ax_g*ax_g + ay_g*ay_g + az_g*az_g)
	float acc_mag_ms2 = acc_mag_g * 9.80665f;
	
	
	int adc = analogRead(ACS_PIN);
	
	float Vadc = ((float)adc / ADC_MAX) * V_REF;

	float Vout = Vadc * ((R1 + R2) / R2);

	float current = (Vout - Vzero_measured) / SENSITIVITY;

	currentFiltered = alpha * current + (1.0f - alpha) * currentFiltered;

	Serial.print("T(C): "); Serial.print(tempC, 2);
	Serial.print(" Acc_g: "); Serial.print(acc_mag_g, 3);
	Serial.print(" Acc_m/s2: "); Serial.print(acc_mag_ms2, 2);
	Serial.print(" ADC: "); Serial.print(adc);
	Serial.print(" Vadc: "); Serial.print(Vadc, 3);
	Serial.print(" Vout: "); Serial.print(Vout, 3);
	Serial.print(" I(A): "); Serial.println(currentFiltred, 3);

	lcd.clear();
	lcd.setCursor(0, 0);
	if (tempC > -100)
	{

		lcd.print("T: ");
		lcd.print(tempC, 1);
		lcd.print("C ");
	} else {

		lcd.print("T: ERR      ");
	}

	lcd.print("I: ");
	lcd.print(currentFiltered, 1);
	lcd.print("A");

	lcd.setCursor(0, 1);
	lcd.print("a:");
	lcd.print(acc_mag_g, 2);
	lcd.print("g ");
	lcd.print(acc_mag_ms2, 0);
	lcd.print("m");

	delay(300);
}

