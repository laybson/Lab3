
EXP_ESCALA_CRESC_COLOR='z = d3.scaleThreshold().domain([-50,0,50,100,200,400,800]).range(d3.schemeRdYlGn[7]),
            d.features.forEach(f => f.properties.fill = z(f.properties["Aumento (%)"])),
            d'

ndjson-map -r d3 -r d3=d3-scale-chromatic \
  "$EXP_ESCALA_CRESC_COLOR" \
< geo4-municipios-e-ensino-simplificado.json \
| ndjson-split 'd.features' \
| geo2svg -n --stroke none -w 1000 -h 600 \
  > necessidades-especiais-choropleth.svg
