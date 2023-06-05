dbt_docs:
	dbt docs generate && \
dbt docs serve

generate_doc:
	dbt run-operation generate_model_yaml --args '{"model_names": ["$(model)"], "upstream_descriptions":true}'
