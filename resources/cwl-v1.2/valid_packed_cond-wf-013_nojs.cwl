class: Workflow
cwlVersion: v1.2
inputs:
- default: [1, 2, 3, 4, 5, 6]
  id: in1
  type: {items: int, type: array}
- default: [false, true, false, true, false, true]
  id: test1
  type: {items: boolean, type: array}
- default: [true, false, true, false, true, false]
  id: test2
  type: {items: boolean, type: array}
outputs:
- id: out1
  linkMerge: merge_flattened
  outputSource: [step1/out1, step2/out1]
  pickValue: all_non_null
  type: {items: string, type: array}
requirements:
- {class: ScatterFeatureRequirement}
- {class: MultipleInputFeatureRequirement}
- {class: SubworkflowFeatureRequirement}
- {class: InlineJavascriptRequirement}
steps:
- id: step1
  in:
  - {id: in1, source: in1}
  - {id: another_var, source: test1}
  out: [out1]
  run:
    baseCommand: [echo]
    class: CommandLineTool
    inputs:
    - {id: in1, type: int}
    outputs:
    - id: out1
      outputBinding: {outputEval: foo $(inputs.in1)}
      type: string
    requirements:
    - {class: InlineJavascriptRequirement}
  scatter: [in1, another_var]
  scatterMethod: dotproduct
  when: $(inputs.another_var)
- id: step2
  in:
  - {id: in1, source: in1}
  - {id: another_var, source: test2}
  out: [out1]
  run:
    baseCommand: [echo]
    class: CommandLineTool
    inputs:
    - {id: in1, type: int}
    outputs:
    - id: out1
      outputBinding: {outputEval: bar $(inputs.in1)}
      type: string
    requirements:
    - {class: InlineJavascriptRequirement}
  scatter: [in1, another_var]
  scatterMethod: dotproduct
  when: $(inputs.another_var)
