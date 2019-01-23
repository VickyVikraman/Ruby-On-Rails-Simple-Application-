app.factory('Details', ["railsResourceFactory", "railsSerializer", function(railsResourceFactory, railsSerializer) {
    var Detail = railsResourceFactory({
        url: '/crud',
        name: 'crud'
    });
    return Detail;
}]);
app.factory('Admin', ["railsResourceFactory", "railsSerializer", function(railsResourceFactory, railsSerializer) {
    var Detail = railsResourceFactory({
        url: '/admin',
        name: 'admin'
    });
    return Detail;
}]);