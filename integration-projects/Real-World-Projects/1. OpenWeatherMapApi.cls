1. Fetch Public API Data
Objective: Learn how to call an external API, handle responses, and display data in Salesforce.

Challenge:

Use the OpenWeatherMap API.
Fetch weather data for a specific city or random facts and store the response in a custom Salesforce object.
Display the data in a Lightning Web Component (LWC).

Steps to accomplish above:
Created Remote Site settings in Salesforce to add the URL of the OpenWeatherMap public API: https://api.openweathermap.org
Went into their website, sign in to get my API key
Created an Object
An App
added custom fields
created an Apex class
public class WeatherService {

    private static final String WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/weather';
    private static final String API_KEY = 'ef3df01b00021fae86fda6a2074a9f40'; // Replace with your actual API key

    @AuraEnabled(cacheable=true)
    public static Weather_Data__c fetchWeather(String city) {
        if (String.isEmpty(city)) {
            throw new AuraHandledException('City name cannot be empty.');
        }

        String apiUrl = WEATHER_API_URL + '?q=' + EncodingUtil.urlEncode(city, 'UTF-8') + '&appid=' + API_KEY + '&units=metric';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(apiUrl);
        req.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            Map<String, Object> weatherResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            
            Weather_Data__c weather = new Weather_Data__c();
            weather.City__c = (String) weatherResponse.get('name');
            
           
            Map<String, Object> main = (Map<String, Object>) weatherResponse.get('main');
            if (main != null) {
                weather.Temperature__c = (Decimal) main.get('temp');
                weather.Min_Temp__c = (Decimal) main.get('temp_min');
                weather.Max_Temp__c = (Decimal) main.get('temp_max');
                weather.Feels_Like__c = (Decimal) main.get('feels_like');
            }
            return weather;
        } else {
            throw new AuraHandledException('Failed to fetch weather data.');
        }
    }
}


created an LWC HTML component
<template>
    <lightning-card title="Weather Information" icon-name="utility:cloud" style="color: rgb(0, 106, 255);">
        <div class="slds-p-horizontal_small">
            <lightning-input
                label="Enter City"
                value={city}
                onchange={handleCityChange}>
            </lightning-input>
            <lightning-button
                label="Get Weather"
                onclick={fetchWeathers}
                class="slds-m-top_small">
            </lightning-button>
        </div>
        <template if:true={weatherData}>
            <div class="slds-m-top_medium">
                <p class="slds-p-left_large"><strong>City:</strong> {weatherData.City__c}</p>
                <p class="slds-p-left_large"><strong>Temperature:</strong> {weatherData.Temperature__c}°C</p>
                <p class="slds-p-left_large"><strong>Feels Like:</strong> {weatherData.Feels_Like__c}°C</p>
                <p class="slds-p-left_large"><strong>Min Temp:</strong> {weatherData.Min_Temp__c}°C</p>
                <p class="slds-p-left_large"><strong>Max Temp:</strong> {weatherData.Max_Temp__c}°C</p>
            </div>
        </template>
        <template if:true={error}>
            <div class="slds-m-top_large slds-text-color_error">
                <p>{error}</p>
            </div>
        </template>
    </lightning-card>
</template>

Created LWC JS file

import { LightningElement, track } from 'lwc';
import fetchWeather from '@salesforce/apex/WeatherService.fetchWeather';

export default class WeatherComponent extends LightningElement {
    @track city = '';
    @track weatherData = null;
    @track error;

    handleCityChange(event) {
        this.city = event.target.value;
    }

    async fetchWeathers() {
        this.error = null;
        this.weatherData = null;

        if (!this.city) {
            this.error = 'Please enter a city name.';
            return;
        }

        try {
            const data = await fetchWeather({ city: this.city });
            this.weatherData = data;
        } catch (error) {
            this.error = 'Failed to fetch weather data. Please try again.';
        }
    }
}

LWC XML file
 <isExposed>true</isExposed>
    <targets>
        <target>lightning__AppPage</target>
        <target>lightning__RecordPage</target>
        <target>lightning__HomePage</target>
    </targets>





