public class List2Set {
    
    public set<string> stringSet{get;set;}
    
    public List2Set(){
        
        List<string> stringList = new List<string>();
        
        stringList.add('Nikhil');
        stringList.add('Vijay');
        stringList.add('Ram');
        
        stringSet = new set<string>();
        
        stringSet.add('one');
        stringSet.add('two');
        stringSet.add('three');
        stringSet.add('four');
        stringSet.add('five');
        stringSet.add('six');
        stringSet.add('seven');
        stringSet.addAll(stringList);
        
        
    }

}