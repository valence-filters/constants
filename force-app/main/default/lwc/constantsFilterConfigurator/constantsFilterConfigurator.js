/**
 * Custom UI for building configurations for the ConstantFilter Valence Filter.
 */

import ValenceUIConfigurator from 'c/valenceUIConfigurator';

export default class ConstantsFilterConfigurator extends ValenceUIConfigurator {

	fieldChange(event) {
		this.configuration.fieldName = event.target.value;
		this.configUpdated();
	}

	valueChange(event) {
		this.configuration.value = event.target.value;
		this.configUpdated();
	}

	// -----------------------------------------
	// ----- Required Configurator Methods -----
	// -----------------------------------------

	getDefaultShape() {
		return {fieldName : null, value : null};
	}

	computeValid() {
		// valid if both fields have values
		return Boolean(this.configuration.fieldName) && Boolean(this.configuration.value);
	}
}