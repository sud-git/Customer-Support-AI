/**
 * InspectionSummaryService
 * Generates AI-powered summaries for order inspections
 * Analyzes quality metrics and provides recommendations
 */
public class InspectionSummaryService {
    
    /**
     * Generate summary for inspection record
     */
    public static void generateInspectionSummary(List<Inspection__c> inspections) {
        List<Inspection__c> inspectionsToUpdate = new List<Inspection__c>();
        
        for (Inspection__c inspection : inspections) {
            if (String.isBlank(inspection.AISummary__c)) {
                String summary = createAISummary(inspection);
                inspection.AISummary__c = summary;
                inspectionsToUpdate.add(inspection);
            }
        }
        
        if (!inspectionsToUpdate.isEmpty()) {
            try {
                update inspectionsToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating inspection summaries: ' + e.getMessage());
                throw new AuraHandledException('Failed to update inspection: ' + e.getMessage());
            }
        }
    }
    
    /**
     * Create AI-generated summary based on inspection data
     */
    private static String createAISummary(Inspection__c inspection) {
        String summary = '';
        
        // Build summary based on quality score
        if (inspection.QualityScore__c != null) {
            Decimal scorePercentage = inspection.QualityScore__c;
            
            if (scorePercentage >= 90) {
                summary += 'EXCELLENT QUALITY: ';
            } else if (scorePercentage >= 80) {
                summary += 'GOOD QUALITY: ';
            } else if (scorePercentage >= 60) {
                summary += 'ACCEPTABLE QUALITY: ';
            } else {
                summary += 'QUALITY CONCERNS: ';
            }
        }
        
        // Add defect information
        if (inspection.DefectsFound__c != null && inspection.DefectsFound__c > 0) {
            summary += inspection.DefectsFound__c + ' defects found. ';
        } else {
            summary += 'No defects detected. ';
        }
        
        // Add status-specific recommendations
        if (inspection.InspectionStatus__c == 'Passed') {
            summary += 'Item approved for shipment.';
        } else if (inspection.InspectionStatus__c == 'Failed') {
            summary += 'Item requires rework or rejection. Contact QA supervisor.';
        } else {
            summary += 'Inspection in progress. Awaiting final review.';
        }
        
        // Add timestamp
        summary += ' Generated: ' + System.now().format('yyyy-MM-dd HH:mm:ss');
        
        return summary;
    }
    
    /**
     * Calculate average quality scores by category
     */
    public static Map<String, Decimal> getAverageQualityScores(String orderId) {
        Map<String, Decimal> scoreMap = new Map<String, Decimal>();
        
        List<AggregateResult> results = [
            SELECT InspectionStatus__c status, AVG(QualityScore__c) avgScore
            FROM Inspection__c
            WHERE OrderLink__c = :orderId
            GROUP BY InspectionStatus__c
        ];
        
        for (AggregateResult ar : results) {
            scoreMap.put((String)ar.get('status'), (Decimal)ar.get('avgScore'));
        }
        
        return scoreMap;
    }
    
    /**
     * Get inspection statistics for reporting
     */
    public static InspectionStatistics getInspectionStats(Date startDate, Date endDate) {
        InspectionStatistics stats = new InspectionStatistics();
        
        List<AggregateResult> results = [
            SELECT 
                InspectionStatus__c status,
                COUNT() countRecords,
                AVG(QualityScore__c) avgQuality,
                MIN(QualityScore__c) minQuality,
                MAX(QualityScore__c) maxQuality
            FROM Inspection__c
            WHERE InspectionDate__c >= :startDate 
                AND InspectionDate__c <= :endDate
            GROUP BY InspectionStatus__c
        ];
        
        for (AggregateResult ar : results) {
            String status = (String)ar.get('status');
            Integer count = (Integer)ar.get('expr0');
            Decimal avgQuality = (Decimal)ar.get('expr1');
            
            if (status == 'Passed') {
                stats.passCount = count;
                stats.avgPassQuality = avgQuality;
            } else if (status == 'Failed') {
                stats.failCount = count;
                stats.avgFailQuality = avgQuality;
            }
        }
        
        stats.totalCount = stats.passCount + stats.failCount;
        if (stats.totalCount > 0) {
            stats.passRate = (stats.passCount / stats.totalCount) * 100;
        }
        
        return stats;
    }
    
    /**
     * Trigger handler for inspection records
     */
    public static void handleInspectionTrigger(List<Inspection__c> newRecords, List<Inspection__c> oldRecords, Boolean isInsert, Boolean isUpdate) {
        if (isInsert) {
            generateInspectionSummary(newRecords);
        } else if (isUpdate) {
            // Update summaries if status or score changed
            List<Inspection__c> changed = new List<Inspection__c>();
            for (Integer i = 0; i < newRecords.size(); i++) {
                if (newRecords[i].InspectionStatus__c != oldRecords[i].InspectionStatus__c ||
                    newRecords[i].QualityScore__c != oldRecords[i].QualityScore__c) {
                    changed.add(newRecords[i]);
                }
            }
            if (!changed.isEmpty()) {
                generateInspectionSummary(changed);
            }
        }
    }
    
    /**
     * Inner class for inspection statistics
     */
    public class InspectionStatistics {
        public Integer totalCount = 0;
        public Integer passCount = 0;
        public Integer failCount = 0;
        public Decimal passRate = 0.0;
        public Decimal avgPassQuality = 0.0;
        public Decimal avgFailQuality = 0.0;
    }
}
