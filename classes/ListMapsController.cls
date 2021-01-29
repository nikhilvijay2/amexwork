public class ListMapsController {
    
    public Map<string,string> inputfields{get;set;}
    
    public ListMapsController(){
        inputfields = new Map<string, string>{'firstname'=>'Johnny', 'lastname' => 'applessed', 'age' => '42'};
    }
    
    public pageReference submitFieldData(){
        dosomethinginterestingwithinput();
        return null;
    }
    
    public void dosomethinginterestingwithinput(){
        inputfields.put('age', Integer.valueOf(inputfields.get('age')).format());
    }

}