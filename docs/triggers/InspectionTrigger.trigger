/**
 * InspectionTrigger
 * Automatically generates AI summaries for quality inspections
 * Fires on: Insert, Update
 * Calls: InspectionSummaryService Apex class
 */
trigger InspectionTrigger on Inspection__c (before insert, before update) {
    InspectionSummaryService.handleInspectionTrigger(
        Trigger.new,
        Trigger.old,
        Trigger.isInsert,
        Trigger.isUpdate
    );
}
