class: Workflow
cwlVersion: v1.2
inputs:
- {id: file1, type: File}
outputs:
- {id: count_output, outputSource: step2/parseInt_output, type: int}
requirements:
- {class: InlineJavascriptRequirement}
- {class: SubworkflowFeatureRequirement}
steps:
- id: step1
  in:
  - {id: wc_file1, source: file1}
  out: [wc_output]
  run:
    baseCommand: wc
    class: CommandLineTool
    id: wc
    inputs:
    - id: wc_file1
      inputBinding: {}
      type: File
    outputs:
    - id: wc_output
      outputBinding: {glob: output.txt}
      type: File
    requirements:
    - {class: InlineJavascriptRequirement}
    stdout: output.txt
- id: step2
  in:
  - {id: parseInt_file1, source: step1/wc_output}
  out: [parseInt_output]
  run:
    class: ExpressionTool
    expression: "${return {'parseInt_output': parseInt(inputs.parseInt_file1.contents)};}\n"
    inputs:
    - {id: parseInt_file1, loadContents: true, type: File}
    outputs:
    - {id: parseInt_output, type: int}
    requirements:
    - {class: InlineJavascriptRequirement}
