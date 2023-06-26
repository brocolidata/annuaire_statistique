{%- 
    set ipc_v1_models = [
        "ipc_agadir_v1_stg",
        "ipc_al_hoceima_v1_stg",
        "ipc_beni_mellal_v1_stg",
        "ipc_casablanca_v1_stg",
        "ipc_dakhla_v1_stg",
        "ipc_fes_v1_stg",
        "ipc_guelmim_v1_stg",
        "ipc_kenitra_v1_stg",
        "ipc_marrakech_v1_stg",
        "ipc_meknes_v1_stg",
        "ipc_oujda_v1_stg",
        "ipc_rabat_v1_stg",
        "ipc_safi_v1_stg",
        "ipc_settat_v1_stg",
        "ipc_tanger_v1_stg",
        "ipc_tetouan_v1_stg"
    ]
-%}
{%- 
    set ipc_v2_models = [
        "ipc_agadir_v2_stg",
        "ipc_al_hoceima_v2_stg",
        "ipc_beni_mellal_v2_stg",
        "ipc_casablanca_v2_stg",
        "ipc_dakhla_v2_stg",
        "ipc_errachidia_v1_stg",
        "ipc_fes_v2_stg",
        "ipc_guelmim_v2_stg",
        "ipc_kenitra_v2_stg",
        "ipc_marrakech_v2_stg",
        "ipc_meknes_v2_stg",
        "ipc_oujda_v2_stg",
        "ipc_rabat_v2_stg",
        "ipc_safi_v2_stg",
        "ipc_settat_v2_stg",
        "ipc_tanger_v2_stg",
        "ipc_tetouan_v2_stg"
    ]
-%}
{% for model in ipc_v1_models %}
{% if loop.first %}with{% endif %} {{model}}_pivoted as (
    unpivot {{ ref(model) }}
    on columns(* exclude (libelle_fr, libelle_ar))
    into
        name year
        value value
),

{{model}}_year as (
    select
        libelle_fr,
        libelle_ar,
        year::integer as year,
        value,
        '{{model}}'[5:-7] as city,
        2006 as base_year
    from {{model}}_pivoted
),
{% endfor %}

{% for model in ipc_v2_models %}
{{model}}_pivoted as (
    unpivot {{ ref(model) }}
    on columns(* exclude (libelle_fr, libelle_ar))
    into
        name year
        value value
),

{{model}}_year as (
    select
        libelle_fr,
        libelle_ar,
        year::integer as year,
        value,
        '{{model}}'[5:-7] as city,
        2017 as base_year
    from {{model}}_pivoted
),
{% endfor %}

unioned_ipc as (
    {% for model in ipc_v1_models -%}
    select * from {{model}}_year
    union
    {% endfor -%}
    {% for model in ipc_v2_models -%}
    select * from {{model}}_year
    {% if not loop.last %}union{% endif %}  
    {% endfor -%}
),

formated_fr_label as (
    select 
        * exclude (libelle_fr),
        upper(
            strip_accents(libelle_fr)
        ) as libelle_fr
    from unioned_ipc
)

select * from formated_fr_label