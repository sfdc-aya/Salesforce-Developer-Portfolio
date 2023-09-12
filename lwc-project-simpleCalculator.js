simpleCalculator.html
<template>
    <lightning-card title = 'Simple Calculator' icon-name="standard:formula">
        <lightning-layout multiple-rows>
            <lightning-layout-item size="12" padding="'around-medium">
                <lightning-input type="number" name="firstNumber" onchange={numberChangeHandler}></lightning-input>
            </lightning-layout-item>
            <lightning-layout-item size="12" padding="'around-medium">
                <lightning-input type="number" name="secondNumber" onchange={numberChangeHandler}></lightning-input>
            </lightning-layout-item>
            <lightning-layout-item size="12" padding="'around-medium">
                <lightning-button-group>
                    <lightning-button label="Add" icon-name="utility:add" icon-position="right" onclick={addHandler}></lightning-button>
                    <lightning-button label="Subtract" icon-name="utility:dash" icon-position="right" onclick={subHandler}></lightning-button>
                    <lightning-button label="Multiply" iicon-name="utility:close" icon-position="right" onclick={multiplyHandler}></lightning-button>
                    <lightning-button label="Divide" icon-name="utility:magicwand" icon-position="right" onclick={divideHandler}></lightning-button>
                </lightning-button-group>
            </lightning-layout-item>
            <lightning-layout-item size="12" padding="around-medium">
                <lightning-formatted-text value={currentResult}></lightning-formatted-text>
            </lightning-layout-item>
            <lightning-layout-item size="12" padding="around-medium">
                <lightning-input type="checkbox" label="show Previous Result" onchange={showPreviousResultToggle}></lightning-input>
            </lightning-layout-item>
            <lightning-layout-item size="12" padding="around-medium">
                <template if:true={showPreviousResult}>
                    <ul>
                        <template iterator:result={previousResults}>
                            <li key={result.value}>
                                <div if:true={result.first} class="slds-border-top"></div>
                                    <lightning-formatted-text value={result.value}></lightning-formatted-text>
                                <div if:true={result.last} class="slds-border-bottom"></div>
                            </li>
                        </template>
                    </ul>
                </template>
            </lightning-layout-item>
        </lightning-layout>
    </lightning-card>
</template>

simpleCalculator.js
import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    @track currentResult;
    @track previousResults = [];
    @track showPreviousResults = false;

    firstNumber;
    secondNumber;

    numberChangeHandler(event){
        const inputBoxName = event.target.name;
        if(inputBoxName === 'firstNumber'){
            this.firstNumber = event.target.value;
        } else if(inputBoxName === 'secondNumber'){
            this.secondNumber = event.target.value;
        }
    }

    addHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);

        this.currentResult = `Result of ${firstN}+${secondN} is ${firstN+secondN}`;
        this.previousResults.push(this.currentResult);
    }

    subHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);

        this.currentResult = `Result of ${firstN}-${secondN} is ${firstN-secondN}`;
        this.previousResults.push(this.currentResult);
    }

    multiplyHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);

        this.currentResult = `Result of ${firstN}x${secondN} is ${firstN*secondN}`;
        this.previousResults.push(this.currentResult);
    }

    divisionHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);

        this.currentResult = `Result of ${firstN}/${secondN} is ${firstN/secondN}`;
        this.previousResults.push(this.currentResult);
    }

    showPreviousResultToggle(event){
        this.showPreviousResults = event.target.checked;
    }

}
//meta.xml

