class: Workflow
cwlVersion: v1.2
inputs:
- id: inp
  type:
    items:
      fields:
      - {name: instr, type: string}
      name: instr
      type: record
    type: array
outputs:
- id: out
  outputSource: step1/echo_out
  type: {items: string, type: array}
requirements:
- {class: ScatterFeatureRequirement}
- {class: StepInputExpressionRequirement}
- {class: SubworkflowFeatureRequirement}
- {class: InlineJavascriptRequirement}
steps:
- id: step1
  in:
  - {id: echo_in, source: inp, valueFrom: $(self.instr)}
  - {id: first, source: inp, valueFrom: $(inputs.echo_in.instr)}
  out: [echo_out]
  run:
    arguments: [-n, foo]
    baseCommand: echo
    class: CommandLineTool
    inputs:
    - id: first
      inputBinding: {position: 1}
      type: string
    - id: echo_in
      inputBinding: {position: 2}
      type: string
    outputs:
    - id: echo_out
      outputBinding: {glob: step1_out, loadContents: true, outputEval: '$(self[0].contents)'}
      type: string
    requirements:
    - {class: InlineJavascriptRequirement}
    stdout: step1_out
  scatter: echo_in
