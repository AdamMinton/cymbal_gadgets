project_name: "cymbal_gadgets"

constant: star_rating_html {
  value: "
  <div style='display: inline-block; white-space: nowrap;'>
  {% assign percentage = value | plus: 0 | times: 20 %}
  <div style='display: inline-block; font-size: 20px; line-height: 1; letter-spacing: 2px; vertical-align: middle;'>
  <div style='height: 0px; overflow: visible; color: #E0E0E0;'>☆☆☆☆☆</div>
  <div style='width: {{ percentage }}%; overflow: hidden; white-space: nowrap; color: #FFD700;'>★★★★★</div>
  </div>
  <div style='display: inline-block; width: 45px; text-align: left; font-size: 14px; color: #666; margin-left: 5px; vertical-align: middle;'>
  ({{ value }})
  </div>
  </div>"
}

