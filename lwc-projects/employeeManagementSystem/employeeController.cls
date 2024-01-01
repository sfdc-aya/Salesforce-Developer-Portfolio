public with sharing class EmployeeManagementSystemController {
    @AuraEnabled(cacheable=true)
    public static List<Employee__c> getEmployees() {
        return [SELECT Id, Name, Job_Title__c, Department__c, Contact_Information__c FROM Employee__c ORDER BY Name LIMIT 100];
    }

    @AuraEnabled
    public static Employee__c getEmployeeById(String employeeId) {
        return [SELECT Id, Name, Job_Title__c, Department__c, Contact_Information__c FROM Employee__c WHERE Id = :employeeId LIMIT 1];
    }

    @AuraEnabled
    public static void saveEmployee(Employee__c employee) {
        upsert employee;
    }

    @AuraEnabled
    public static void deleteEmployee(String employeeId) {
        delete [SELECT Id FROM Employee__c WHERE Id = :employeeId LIMIT 1];
    }
}
