public with sharing class WeatherTrackerController {
    public class WeatherInfo {
        @AuraEnabled public String cityName { get; set; }
        @AuraEnabled public String temperature { get; set; }
        @AuraEnabled public String condition { get; set; }
    }

    @AuraEnabled(cacheable=true)
    public static WeatherInfo getWeatherInfo(String cityName) {
        // Call an external weather API to get the weather information
        // Replace the following line with actual API call logic

        // For demo purposes, returning static data
        WeatherInfo info = new WeatherInfo();
        info.cityName = 'San Francisco';
        info.temperature = '20°C';
        info.condition = 'Sunny';

        return info;
    }
}
