/**
 * Allows a User to configure a static value that will be added to each record as a source field.
 */
global with sharing class ConstantsFilter implements valence.SchemaAwareTransformationFilter, valence.ConfigurablePerLinkFilter {

	private List<Configuration> configs = new List<Configuration>();

	public String getFilterConfigurationLightningComponent() {
		return 'c:constantsFilterConfigurator';
	}

	public String getFilterConfigurationStructure() {
		return null;
	}

	public String explainFilterConfiguration(String configurationData) {

		try {
			Configuration config = buildConfiguration(configurationData);

			return String.format('A source field called <strong>{0}</strong> with the value of <strong>{1}</strong> will be added to each record.', new List<Object>{
				config.fieldName,
				config.value
			});
		}
		catch(Exception e) {
			return '<p class="slds-theme_error">The configuration for this Filter is malformed.</p>';
		}
	}

	public void setFilterConfigurations(valence.LinkContext context, List<String> configurationData) {
		configs.clear();
		for(String rawConfig : configurationData) {
			if(String.isNotBlank(rawConfig)) {
				configs.add(buildConfiguration(rawConfig));
			}
		}
	}

	public Boolean validFor(valence.LinkContext context) {
		return true;
	}

	public void process(valence.LinkContext context, List<valence.RecordInFlight> records) {

		// add our static values to each record
		for(valence.RecordInFlight record : records) {
			for(Configuration config : configs) {
				record.setOriginalProperty(valence.FieldPath.buildPath(config.fieldName), config.value);
			}
		}
	}

	public valence.FilterSchema describeSchema(valence.LinkContext context) {
		valence.FilterSchema schema = new valence.FilterSchema();

		for(Configuration config : configs) {
			schema.createsSourceField(valence.Field.create(config.fieldName)
				.withDescription(String.format('A static field created by the Constants Filter whose value will always be <strong>{0}</strong>', new List<Object>{config.value})).build());
		}
		return schema;
	}

	private Configuration buildConfiguration(String jsonData) {
		// we deserializeUntyped so that we can let value be the Object type, which the JSON class will not deserialize to if class-restricted
		return new Configuration((Map<String, Object>)JSON.deserializeUntyped(jsonData));
	}

	/**
	 * Defines a structure for the configuration of this filter.
	 */
	private class Configuration {

		// name of newly-created field that will be added to the source properties of the record
		private String fieldName;

		// the static value that will be put in the field
		private Object value;

		private Configuration(Map<String, Object> untyped) {
			fieldName = (String)untyped.get('fieldName');
			value = untyped.get('value');
		}
	}
}