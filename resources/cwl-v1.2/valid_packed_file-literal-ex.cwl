class: ExpressionTool
cwlVersion: v1.2
expression: "${\nreturn {\"lit\": {\"class\": \"File\", \"basename\": \"a_file\",\
  \ \"contents\": \"Hello file literal.\"}};\n}"
inputs: []
outputs:
- {id: lit, type: File}
requirements:
- {class: InlineJavascriptRequirement}
