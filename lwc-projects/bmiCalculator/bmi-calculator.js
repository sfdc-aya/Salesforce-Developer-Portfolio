import { LightningElement, track } from 'lwc';

export default class BmiCalculator extends LightningElement {
   @track weight = '';
   @track height = '';
   @track bmi = '';

    weightChange(event){
        this.weight = parseFloat(event.target.value);
    }

    heightChange(event){
        this.height = parseFloat(event.target.value);
    }

    calculateBMI(){
        this.bmi = ((this.weight / (this.height * this.height)) * 10000).toFixed(1);
    }

    resetFields(event){
        this.weight = '';
        this.height = '';
        this.bmi = '';
    }
}
