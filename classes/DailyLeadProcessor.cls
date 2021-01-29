global class DailyLeadProcessor implements Schedulable{
    
    global void execute(SchedulableContext ctx){
        
        List<Lead> leList = new List<Lead>([Select id, Name from Lead Where Leadsource = NULL LIMIT 200]);
        
        for(Lead lea: leList){
            
        lea.LeadSource = 'Dreamforce';
        }
        
        if(leList.size()>0){
          update leList;  
        }
        
    }

}