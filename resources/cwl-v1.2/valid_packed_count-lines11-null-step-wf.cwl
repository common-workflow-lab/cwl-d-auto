class: Workflow
cwlVersion: v1.2
inputs: []
outputs:
- {id: count_output, outputSource: step2/output, type: int}
requirements:
- {class: SubworkflowFeatureRequirement}
- {class: InlineJavascriptRequirement}
steps:
- id: step0
  in: []
  out: [output]
  run:
    class: ExpressionTool
    expression: "$({'output': null })"
    inputs: []
    outputs:
    - {id: output, type: Any}
    requirements:
    - {class: InlineJavascriptRequirement}
- id: step1
  in:
  - default: {class: File, location: whale.txt}
    id: file1
    source: step0/output
  out: [output]
  run:
    baseCommand: [wc, -l]
    class: CommandLineTool
    inputs:
    - {id: file1, type: File}
    outputs:
    - id: output
      outputBinding: {glob: output}
      type: File
    requirements:
    - {class: InlineJavascriptRequirement}
    stdin: $(inputs.file1.path)
    stdout: output
- id: step2
  in:
  - {id: file1, source: step1/output}
  out: [output]
  run:
    class: ExpressionTool
    expression: "$({'output': parseInt(inputs.file1.contents)})"
    inputs:
    - {id: file1, loadContents: true, type: File}
    outputs:
    - {id: output, type: int}
    requirements:
    - {class: InlineJavascriptRequirement}
