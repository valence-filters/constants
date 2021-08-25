# Constants

This is a custom extension for <a href="https://valence.app">Valence</a>, a <a href="https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000EORP4UAP">managed package on the Salesforce AppExchange</a> that provides integration middleware natively in a Salesforce org.

To learn more about developing extensions for the Valence platform, check out <a href="https://docs.valence.app">the Valence documentation</a>.

## Installing

Click this button to install the Filter into your org.

<a href="https://githubsfdeploy.herokuapp.com?owner=valence-filters&repo=constants&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## What Does This Filter Do?

Allows a User to configure a static value that will be added to each record as a source field.

You can set up more than one configuration of this Filter on the same Link, in case you need multiple static value fields.

### Configuring the Filter

![Here's what configuring the Filter looks like](/images/configuring.png)

Make sure you have Constants Filter set up to run before Mappings so that you can use the constant values in your mappings.

### What You See Once Configured

![Each configuration shows an explanation of its effects](/images/explainer.png)

### Effect on Records

At runtime this Filter will add a field with a static value to each record based on a configuration, and multiple fields if there are multiple configurations.

![Here's what records look like because of this Filter](/images/results.png)