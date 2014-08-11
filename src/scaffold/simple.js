module.exports = function(){
  this.Given(/^I visit TODOMVC$/,function(){
    this.driver.get('http://todomvc.com/architecture-examples/backbone/')
  });

  this.When(/^I enter \"([^\"]*)\"$/, function(value){
    new this.Widget({
      root: "#new-todo"
    }).sendKeys(value,'\uE007');
  });

  this.Then(/^I should see \"([^\"]*)\"$/, function(expected){
    var List = this.Widget.List.extend({
      root: "#todo-list",
      childSelector: "li"
    })

    return new List().readAt(0).should.eventually.eql(expected);
  })
}
