"use strict";
/* eslint new-cap: 0 */

require('should');

var GherkinParser = require('../../lib/parser/gherkin.js');

function unwrapSingleColumnTable(singleColumnTable) {
  return (singleColumnTable.raw()).map(function (valueWrappedInArray) {return valueWrappedInArray[0]});
}

module.exports = function() {
  // Shared variables
  var featureText;
  var features;

  this.Given(/^the feature file\.?$/, function (string) {
    featureText = string;
  });

  this.When(/^I parse this specification\.?$/, function () {
    var parser = new GherkinParser();
    var visitor = parser.parse(featureText);
    features = visitor.getFeatures();
  });

  this.Then(/^I get a feature with title "([^"]*)"\.?$/, function (featureTitle) {
    features[0].name.should.be.exactly(featureTitle);
  });

  this.Then(/^scenarios with titles$/, function (table) {
    for(var i = 0; i < table.raw().length; i++) {
      var row = table.raw()[i];
      var scenario = features[0].scenarios[i];
      scenario.name.should.be.exactly(row[0]);
    }
  });

  this.Then(/^feature tags are associated with features\.?$/, function (table) {
    var featureTags = features[0].tags;
    var expectedTags = unwrapSingleColumnTable(table);
    featureTags.should.containDeepOrdered(expectedTags);
  });

  this.Then(/^scenario tags are associated with scenarios\.?$/, function (table) {
    var scenarioTags = features[0].scenarios[0].tags;
    var expectedTags = unwrapSingleColumnTable(table);
    scenarioTags.should.containDeepOrdered(expectedTags);
  });

  this.Then(/^feature comments are associated with features\.?$/, function (table) {
    var featureComments = features[0].comments;
    var expectedComments = unwrapSingleColumnTable(table);
    featureComments.should.containDeepOrdered(expectedComments);
  });

  this.Then(/^scenario comments are associated with scenarios\.?$/, function (table) {
    var scenarioComments = features[0].scenarios[0].comments;
    var expectedComments = unwrapSingleColumnTable(table);
    scenarioComments.should.containDeepOrdered(expectedComments);
  });
};
