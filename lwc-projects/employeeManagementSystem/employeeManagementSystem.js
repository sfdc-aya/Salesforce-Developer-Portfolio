import { LightningElement, wire } from 'lwc';
import getEmployees from '@salesforce/apex/EmployeeController.getEmployees';
import getEmployeeById from '@salesforce/apex/EmployeeController.getEmployeeById';
import saveEmployee from '@salesforce/apex/EmployeeController.saveEmployee';
import deleteEmployee from '@salesforce/apex/EmployeeController.deleteEmployee';

const columns = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Job Title', fieldName: 'Job_Title__c', type: 'text' },
    { label: 'Department', fieldName: 'Department__c', type: 'text' },
    { label: 'Contact Information', fieldName: 'Contact_Information__c', type: 'text' },
    { type: 'button', label: 'View Details', initialWidth: 135, typeAttributes: { label: 'View Details', name: 'view_details' } }
];

export default class EmployeeManagementSystem extends LightningElement {
    employees;
    columns = columns;
    showCreateModal = false;

    @wire(getEmployees)
    wiredEmployees({ error, data }) {
        if (data) {
            this.employees = data;
        } else if (error) {
            console.error('Error fetching employee data: ' + error);
        }
    }

    openCreateModal() {
        this.showCreateModal = true;
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case 'view_details':
                this.handleViewDetails(row.Id);
                break;
            // Add more actions as needed
        }
    }

    handleViewDetails(employeeId) {
        getEmployeeById({ employeeId })
            .then(result => {
                // Handle the result, e.g., display details in a modal
            })
            .catch(error => {
                console.error('Error fetching employee details: ' + error);
            });
    }

    handleSuccess() {
        this.showCreateModal = false;
        // Refresh the employee data after a successful save
        refreshApex(this.employees);
    }

    handleCancel() {
        this.showCreateModal = false;
    }
}
