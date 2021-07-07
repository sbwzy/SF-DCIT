/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-05-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-05-2021   robert   Initial Version
**/
@isTEst
public class TemperatureConverterTest {
    @isTest static void testWarmTemp(){
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11, celsius);
    }

    @isTest static void testFreezingPoint(){
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(32);
        System.assertEquals(0, celsius);
    }

    @isTest static void testBoilingPoint(){
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);
        System.assertEquals(100, celsius, '不期望沸点温度');
    }

    @isTest static void testNegativeTemp(){
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33, celsius);
    }
}