
dsv2json  \
  -r ',' \
  -n < necessidadesespeciais.csv \
  > necessidades-especiais.ndjson

ndjson-split 'd.features' \
  < geo1-br_municipios_projetado.json \
  | ndjson-map 'd.GEOCODIGO = Number(d.properties.GEOCODIGO), d' \
  > geo2-br_municipios_projetado.ndjson

ndjson-map 'd.GEOCODIGO = Number(d.GEOCODIGO), d' \
< necessidades-especiais.ndjson \
> necessidades-especiais2.ndjson



EXP_PROPRIEDADE='d[0].properties = Object.assign({}, d[0].properties, d[1]), d[0]'
ndjson-join --left 'd.GEOCODIGO' \
  geo2-br_municipios_projetado.ndjson \
  necessidades-especiais2.ndjson \
  | ndjson-map \
    "$EXP_PROPRIEDADE" \
  > geo3-municipios-e-ensino.ndjson

geo2topo -n \
  tracts=- \
< geo3-municipios-e-ensino.ndjson \
| toposimplify -p 1 -f \
| topoquantize 1e5 \
| topo2geo tracts=- \
> geo4-municipios-e-ensino-simplificado.json
