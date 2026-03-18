/**
 * CaseTrigger
 * Automatically processes cases for AI summaries and intelligent routing
 * Fires on: Insert, Update
 * Calls: CaseAutoResponder Apex class
 */
trigger CaseTrigger on Case__c (before insert, before update, after insert, after update) {
    if (Trigger.isInsert || Trigger.isUpdate) {
        // Process AI summaries for new or updated cases
        CaseAutoResponder.handleCaseTrigger(
            Trigger.new,
            Trigger.old,
            Trigger.isInsert,
            Trigger.isUpdate
        );
    }
}
