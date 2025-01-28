import { LightningElement, wire, track } from 'lwc';
import getEmployeeList from '@salesforce/apex/EmployeeController.getEmployeeList';

export default class EmployeeList extends LightningElement {
    @track employees;
    @track currentPage = 1;
    @track totalRecords;

    @wire(getEmployeeList, { page: '$currentPage' })
    wiredEmployeeData({ error, data }) {
        if (data) {
            this.employees = data.employees;
            this.totalRecords = data.totalRecords;
        } else if (error) {
            console.error('Error fetching employee data: ', error);
        }
    }

    handlePagination(event) {
        this.currentPage = event.detail;
    }

    handleViewDetails(event) {
        // Handle logic to navigate to employee details page
    }
}
