import { LightningElement, track } from "lwc";
import saveExpenseRecord from "@salesforce/apex/ExpenseController.saveExpenseRecord";
import { showToastEvent } from "lightning/platformShowToastEvent";

export default class ExpenseTracker extends LightningElement {
  @track amount;
  @track name;
  @track expenseDate;

  handleAmountChange(event) {
    this.amount = event.target.value;
  }

  handleNameChange(event) {
    this.name = event.target.value;
  }

  handleDateChange(event) {
    this.expenseDate = event.target.value;
  }

  saveExpense() {
    saveExpenseRecord({
      amount: this.amount,
      name: this.name,
      dates: this.expenseDate
    })
      .then((recordId) => {
        console.log("Expense saved successfully", recordId);
      })
      .catch((error) => {
        console.error("Error occured during saving the record", error);
      });
  }
}
