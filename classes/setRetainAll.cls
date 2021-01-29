public class setRetainAll {
    
    public set<string> strSet{get;set;}
    
    public boolean test{get;set;}
    
    public setRetainAll(){
        List<string> strList = new List<string>();
        
        strList.add('one');
        strList.add('two');
        
        strSet = new set<string>();
        
        strSet.add('new');
        strSet.add('old');
        test= strSet.retainAll(strList);
    }

}