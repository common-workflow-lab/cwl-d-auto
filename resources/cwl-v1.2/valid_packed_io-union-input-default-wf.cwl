class: Workflow
cwlVersion: v1.2
inputs:
- default: the default value
  id: bar
  type: [File, 'null', string]
outputs:
- {id: o, outputSource: step1/o, type: string}
requirements:
- {class: InlineJavascriptRequirement}
- {class: SubworkflowFeatureRequirement}
steps:
- id: step1
  in:
  - {id: i, source: bar}
  out: [o]
  run:
    class: ExpressionTool
    expression: "${return {'o': (inputs.i.class || inputs.i)};}\n"
    inputs:
    - id: i
      type: [File, 'null', string]
    outputs:
    - {id: o, type: string}
    requirements:
    - {class: InlineJavascriptRequirement}
