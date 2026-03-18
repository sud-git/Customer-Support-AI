/**
 * CustomerSupportUtility
 * Utility class for common operations in customer support system
 */
public class CustomerSupportUtility {
    
    /**
     * Calculate customer lifetime value
     */
    public static Decimal calculateLifetimeValue(String customerId) {
        List<Order__c> orders = [
            SELECT TotalAmount__c
            FROM Order__c
            WHERE CustomerLink__c = :customerId
        ];
        
        Decimal totalValue = 0;
        for (Order__c order : orders) {
            if (order.TotalAmount__c != null) {
                totalValue += order.TotalAmount__c;
            }
        }
        
        return totalValue;
    }
    
    /**
     * Get recent cases for a customer
     */
    public static List<Case__c> getRecentCases(String customerId, Integer limitRecords) {
        return [
            SELECT Id, Name, CaseTitle__c, Status__c, Priority__c, CreatedDate__c
            FROM Case__c
            WHERE CustomerLink__c = :customerId
            ORDER BY CreatedDate__c DESC
            LIMIT :limitRecords
        ];
    }
    
    /**
     * Get product recommendations based on previous orders
     */
    public static List<Merchandise__c> getProductRecommendations(String customerId, Integer limitRecords) {
        // Get customer's previous orders and products
        Set<Id> purchasedProducts = new Set<Id>();
        
        List<Order__c> orders = [
            SELECT Id
            FROM Order__c
            WHERE CustomerLink__c = :customerId
        ];
        
        // In a real scenario, you'd have an order line item object
        // This is a simplified version
        
        // Return active products not previously purchased
        return [
            SELECT Id, Name, Category__c, Price__c, Stock__c
            FROM Merchandise__c
            WHERE IsActive__c = true
            ORDER BY Price__c DESC
            LIMIT :limitRecords
        ];
    }
    
    /**
     * Validate customer information
     */
    public static ValidationResult validateCustomer(Customer__c customer) {
        ValidationResult result = new ValidationResult();
        
        if (String.isBlank(customer.CustomerName__c)) {
            result.addError('Customer name is required');
        }
        
        if (String.isBlank(customer.CustomerEmail__c)) {
            result.addError('Customer email is required');
        } else if (!customer.CustomerEmail__c.contains('@')) {
            result.addError('Invalid email format');
        }
        
        return result;
    }
    
    /**
     * Format currency for display
     */
    public static String formatCurrency(Decimal amount) {
        if (amount == null) {
            return '$0.00';
        }
        return '$' + amount.toPlainString();
    }
    
    /**
     * Get case resolution time (in hours)
     */
    public static Decimal getCaseResolutionTimeHours(Case__c caseRecord) {
        if (caseRecord.CreatedDate__c != null && caseRecord.ResolvedDate__c != null) {
            Long milliseconds = caseRecord.ResolvedDate__c.getTime() - caseRecord.CreatedDate__c.getTime();
            return Decimal.valueOf(milliseconds / (1000 * 60 * 60));
        }
        return 0;
    }
    
    /**
     * Inner class for validation results
     */
    public class ValidationResult {
        public Boolean isValid = true;
        public List<String> errors = new List<String>();
        
        public void addError(String errorMessage) {
            isValid = false;
            errors.add(errorMessage);
        }
    }
}
