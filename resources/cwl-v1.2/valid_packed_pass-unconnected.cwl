class: Workflow
cwlVersion: v1.2
inputs:
- {default: hello inp1, id: inp1, type: string}
- {default: hello inp2, id: inp2, type: string}
outputs:
- {id: out, outputSource: step1/out, type: string}
requirements:
- {class: SubworkflowFeatureRequirement}
- {class: InlineJavascriptRequirement}
steps:
- id: step1
  in:
  - {id: in, source: inp1}
  - {id: in2, source: inp2}
  out: [out]
  run:
    baseCommand: echo
    class: CommandLineTool
    inputs:
    - id: in
      inputBinding: {}
      type: Any
    outputs:
    - id: out
      outputBinding: {glob: out.txt, loadContents: true, outputEval: '$(self[0].contents)'}
      type: string
    requirements:
    - {class: InlineJavascriptRequirement}
    stdout: out.txt
