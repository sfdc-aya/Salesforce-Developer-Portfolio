import { LightningElement, track, api } from 'lwc';

export default class PublicMethodChild extends LightningElement {
    @track value = ['red'];

    options = [
        { label: 'Yellow Marker', value: 'yellow' },
        { label: 'Gold Marker', value: 'gold' },
        { label: 'Green Marker', value: 'green' },
        { label: 'Black Marker', value: 'black' },
        { label: 'Blue Marker', value: 'blue' },
        { label: 'White Marker', value: 'white' },
        { label: 'Purple Marker', value: 'purple' },
        { label: 'Grey Marker', value: 'grey' },
        { label: 'Red Marker', value: 'red' },
    ];


    @api
    selectCheckbox(checkboxValue){
        const selectedCheckbox = this.options.find( checkbox =>{
            return checkboxValue === checkbox.value;
        })

        if(selectedCheckbox){
            this.value = selectedCheckbox.value;
            return "Successfully checked";
        } 
        return "No checkbox found";
        
    }

}
