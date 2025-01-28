import { LightningElement, track } from 'lwc';
import getWeatherInfo from '@salesforce/apex/WeatherTrackerController.getWeatherInfo';

export default class WeatherTrackerLWC extends LightningElement {
    @track cityName = '';
    @track weatherInfo;

    handleCityChange(event) {
        this.cityName = event.target.value;
    }

    getWeather() {
        getWeatherInfo({ cityName: this.cityName })
            .then(result => {
                this.weatherInfo = result;
            })
            .catch(error => {
                console.error('Error fetching weather information:', error);
            });
    }
}

