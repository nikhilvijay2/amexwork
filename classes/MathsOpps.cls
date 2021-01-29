public class MathsOpps {
    
    public Integer aValue{get;set;}
    
    public Integer bValue{get;set;}
    
    public string operation{get;set;}
    
    public Integer result{get;set;}
    
    public PageReference subb(){
        result = aValue + bValue;
        operation = 'Addition';
        return null;
    }
    
    public PageReference subb1(){
        result = aValue - bValue;
        operation = 'Substraction';
        return null;
    }
    
    

}