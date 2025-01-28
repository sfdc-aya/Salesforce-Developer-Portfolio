11.Objective: Learn how to call an external API, handle responses, and display data in Salesforce.

Challenge:

Use the Joke API.
Fetch random joke data on a click of a button from an external Public API.
Display the data in a Lightning Web Component (LWC).

Steps to accomplish above:
Created Remote Site settings in Salesforce to add the URL of the Joke public API: https://official-joke-api.appspot.com

created an Apex class
public with sharing class JokeService {
    @AuraEnabled
    public static String getRandomJoke() {
        String endpoint = 'https://v2.jokeapi.dev/joke/Any?type=twopart';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Accept', 'application/json');
        
        try {
            HttpResponse response = http.send(request);
            
            // Check if the response is valid
            if (response.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                String joke = '';
                if (jsonResponse.containsKey('setup') && jsonResponse.containsKey('delivery')) {
                    String setup = (String) jsonResponse.get('setup');
                    String delivery = (String) jsonResponse.get('delivery');
                    joke = setup + ' - ' + delivery;
                } else if (jsonResponse.containsKey('joke')) {
                    joke = (String) jsonResponse.get('joke');
                }
                return joke;
            } else {
                return 'Failed to fetch joke. Status: ' + response.getStatus();
            }
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
}

Created LWC HTML file
<template>
    <lightning-card title="Get a Random Joke" icon-name="utility:smiley_and_people">
        <div class="slds-p-around_medium">
            <lightning-button label="Fetch Joke" onclick={handleGetJoke} variant="brand"></lightning-button>

            <template if:true={joke}>
                <p class="slds-m-top_medium">{joke}</p>
            </template>

            <template if:true={error}>
                <p class="slds-m-top_medium slds-text-color_error">{error}</p>
            </template>
        </div>
    </lightning-card>
</template>


Created LWC JS file
import { LightningElement } from 'lwc';
import getRandomJoke from '@salesforce/apex/JokeService.getRandomJoke';

export default class JokeComponent extends LightningElement {
    joke = '';
    error = '';

    handleGetJoke() {
        console.log('Button clicked! Fetching new joke...');
        
        getRandomJoke()
            .then((result) => {
                console.log('API Response:', result);
                this.joke = result;
                this.error = ''; 
                console.log('Updated joke:', this.joke);
            })
            .catch((error) => {
                this.joke = ''; 
                this.error = 'Failed to fetch joke: ' + error.body.message;
                console.error('Error:', this.error);
            });
    }
}


Created LWC XML
<?xml version="1.0" encoding="UTF-8"?>
<LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>61.0</apiVersion>
    <isExposed>true</isExposed>
    <targets>
         <target>lightning__AppPage</target>
         <target>lightning__HomePage</target>
         <target>lightning__RecordPage</target>
    </targets>
</LightningComponentBundle>