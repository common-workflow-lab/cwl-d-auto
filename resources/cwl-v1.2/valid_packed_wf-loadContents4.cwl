class: Workflow
cwlVersion: v1.2
inputs:
- {id: my_file, type: File}
outputs:
- {id: my_int, outputSource: one/my_int, type: int}
requirements:
- {class: StepInputExpressionRequirement}
- {class: InlineJavascriptRequirement}
- {class: SubworkflowFeatureRequirement}
steps:
- id: one
  in:
  - {id: my_number, loadContents: true, source: my_file, valueFrom: $(parseInt(self.contents))}
  out: [my_int]
  run:
    class: ExpressionTool
    expression: "${ return { \"my_int\": inputs.my_number }; }\n"
    inputs:
    - {id: my_number, type: int}
    outputs:
    - {id: my_int, type: int}
    requirements:
    - {class: InlineJavascriptRequirement}
