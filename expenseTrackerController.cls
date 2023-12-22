public with sharing class ExpenseController {
    public ExpenseController() {
        Decimal amount;
        String name;
        Date dates;
    }

    @AuraEnabled 
    public static void saveExpenseRecord(Decimal amount, String name, Date dates){
        Expense__c newExpense = new Expense__c(Amount__c = amount, Name = name, Expense_Date__c = dates );
        insert newExpense;
    }
}
