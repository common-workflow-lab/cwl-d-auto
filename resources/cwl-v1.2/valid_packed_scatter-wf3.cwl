$graph:
- arguments: [-n, foo]
  baseCommand: echo
  class: CommandLineTool
  id: echo
  inputs:
    echo_in1:
      inputBinding: {}
      type: string
    echo_in2:
      inputBinding: {}
      type: string
  outputs:
    echo_out:
      outputBinding: {glob: step1_out, loadContents: true, outputEval: '$(self[0].contents)'}
      type: string
  stdout: step1_out
- class: Workflow
  id: main
  inputs: {inp1: 'string[]', inp2: 'string[]'}
  outputs:
    out:
      outputSource: step1/echo_out
      type: {items: string, type: array}
  requirements:
  - {class: ScatterFeatureRequirement}
  steps:
    step1:
      in: {echo_in1: inp1, echo_in2: inp2}
      out: [echo_out]
      run: '#echo'
      scatter: [echo_in1, echo_in2]
      scatterMethod: flat_crossproduct
cwlVersion: v1.2
