// This is a mainApp - See the html-tag
var myApp = angular.module('mainApp',[]);

    // Register the controller (get demoController)
    // Second parameter is the function within the controller is coded
    myApp.controller('DemoController', DemoController); 
    
    // This is Dependency injection
    // I use this annotation so we don´t get problems with minifing (can differs from littature)
    // https://docs.angularjs.org/guide/di
    // Don´t really need this row 
    DemoController.$inject = ['$scope'];
    
    // This is our controller - Should of cource be in a own file...
    function DemoController($scope) {
    
    // Databind (see data-ng-model above) - Scope is the ViewModel => The glue
    $scope.name = "";
    $scope.isShowingProps = false;
    $scope.properties = ["Kind", "Funny", "Admirable"]
    
    // A controller method
    $scope.toggleProps = function() {
     this.isShowingProps = this.isShowingProps ? false : true;
    };
};