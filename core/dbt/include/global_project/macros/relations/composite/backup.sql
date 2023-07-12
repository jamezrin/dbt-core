{%- macro backup_template(relation, called_directly=True) -%}
    {%- if called_directly -%}
        {{- log('Applying BACKUP to: ' ~ relation) -}}
    {%- endif -%}
    {{- adapter.dispatch('backup_template', 'dbt')(relation) -}}
{%- endmacro -%}


{%- macro default__backup_template(relation) -%}

    -- get the standard backup name
    {% set backup_relation_ref = adapter.relation_factory.make_backup_ref(relation) -%}

    -- drop any pre-existing backup
    {{ drop_template(backup_relation_ref, called_directly=False) }};

    {{ rename_template(relation, backup_relation_ref.name, called_directly=False) }}

{%- endmacro -%}