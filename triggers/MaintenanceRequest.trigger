trigger MaintenanceRequest on Case (before update, after update) {
    MaintenanceRequestHelper.updateWorkOrders(Trigger.new);
}