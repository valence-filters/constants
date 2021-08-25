/**
 * Exercises the ConstantsFilter class.
 */
@IsTest
private class ConstantsFilterTests {

	@IsTest static void testWithConfigs() {

		String firstConfig = JSON.serialize(new Map<String, Object>{
			'fieldName' => 'region',
			'value' => 'North'
		});
		String secondConfig = JSON.serialize(new Map<String, Object>{
			'fieldName' => 'size',
			'value' => 'small'
		});

		// setup up an artificial Context to use for our test
		valence.LinkContext context = new valence.LinkContext();
		context.linkTargetName = 'Contact';

		List<valence.RecordInFlight> records = new List<valence.RecordInFlight>{
			new valence.RecordInFlight(new Map<String, Object>{
				'name' => 'George',
				'region' => 'South'
			}),
			new valence.RecordInFlight(new Map<String, Object>{
				'name' => 'Samantha'
			})
		};

		Test.startTest();
		ConstantsFilter filter = new ConstantsFilter();
		filter.setFilterConfigurations(context, new List<String>{firstConfig, secondConfig});
		filter.process(context, records);
		Test.stopTest();

		System.assertEquals(2, records.size());

		System.assertEquals('George', records[0].getOriginalProperty(valence.FieldPath.buildPath('name')));
		System.assertEquals('North', records[0].getOriginalProperty(valence.FieldPath.buildPath('region')));
		System.assertEquals('small', records[0].getOriginalProperty(valence.FieldPath.buildPath('size')));

		System.assertEquals('Samantha', records[1].getOriginalProperty(valence.FieldPath.buildPath('name')));
		System.assertEquals('North', records[1].getOriginalProperty(valence.FieldPath.buildPath('region')));
		System.assertEquals('small', records[1].getOriginalProperty(valence.FieldPath.buildPath('size')));
	}

	@IsTest static void testNoConfigs() {

		// setup up an artificial Context to use for our test
		valence.LinkContext context = new valence.LinkContext();
		context.linkTargetName = 'Contact';

		List<valence.RecordInFlight> records = new List<valence.RecordInFlight>{
			new valence.RecordInFlight(new Map<String, Object>{
				'name' => 'George',
				'region' => 'South'
			}),
			new valence.RecordInFlight(new Map<String, Object>{
				'name' => 'Samantha'
			})
		};

		Test.startTest();
		ConstantsFilter filter = new ConstantsFilter();
		filter.setFilterConfigurations(context, new List<String>());
		filter.process(context, records);
		Test.stopTest();

		System.assertEquals(2, records.size());

		System.assertEquals('George', records[0].getOriginalProperty(valence.FieldPath.buildPath('name')));
		System.assertEquals('South', records[0].getOriginalProperty(valence.FieldPath.buildPath('region')));
		System.assertEquals(null, records[0].getOriginalProperty(valence.FieldPath.buildPath('size')));

		System.assertEquals('Samantha', records[1].getOriginalProperty(valence.FieldPath.buildPath('name')));
		System.assertEquals(null, records[1].getOriginalProperty(valence.FieldPath.buildPath('region')));
		System.assertEquals(null, records[1].getOriginalProperty(valence.FieldPath.buildPath('size')));
	}

	@IsTest static void testRestrictions() {

		System.assertEquals(true, new ConstantsFilter().validFor(null));
	}

	@IsTest static void testConfigurationMethods() {

		ConstantsFilter filter = new ConstantsFilter();

		System.assertEquals('c:ConstantsFilterConfigurator', filter.getFilterConfigurationLightningComponent());
		System.assertEquals(null, filter.getFilterConfigurationStructure());

		String config = JSON.serialize(new Map<String, Object>{
			'fieldName' => 'region',
			'value' => 'East'
		});

		System.assertEquals('A source field called <strong>region</strong> with the value of <strong>East</strong> will be added to each record.', filter.explainFilterConfiguration(config));
	}

	@IsTest static void testSchemaDescribe() {

		String config = JSON.serialize(new Map<String, Object>{
			'fieldName' => 'region',
			'value' => 'East'
		});

		// setup up an artificial Context to use for our test
		valence.LinkContext context = new valence.LinkContext();
		context.linkTargetName = 'Contact';

		Test.startTest();
		ConstantsFilter filter = new ConstantsFilter();
		filter.setFilterConfigurations(context, new List<String>{config});
		filter.describeSchema(context);
		Test.stopTest();
	}
}
