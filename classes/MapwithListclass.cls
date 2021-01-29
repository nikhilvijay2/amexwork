public class MapwithListclass {
    
    Map<string, List<string>> listMap = new Map<string, List<string>>();
    public List<selectOption> city{get;set;}
    public List<selectOption> branch{get;set;}
    
    public MapwithListclass(){
        
        List<string> hydList = new List<string>();
        hydList.add('sr nagar');
        hydList.add('lb nagar');
        
        List<string> langList = new List<string>();
        langList.add('telugu');
        langList.add('hindi');
        langList.add('english');
        
        listMap.put('hyd', hydList);
        listMap.put('lang', langList);
        
        set<string> keys = listMap.keySet();
        
        city = new List<selectOption>();
        branch = new List<selectOption>();
        
        city.add(new selectOption('null', 'none'));
        
        List<string> my = new List<string>();
        my.add('none');
        
        for(string a: keys){
            selectOption op1 = new selectOption(a,a);
            city.add(op1);
        }
        
    }
    
    
}