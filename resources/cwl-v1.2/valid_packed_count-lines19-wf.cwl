class: Workflow
cwlVersion: v1.2
inputs:
- {id: file1, type: File}
outputs:
- {id: count_output, outputSource: step1/output, type: int}
requirements:
- {class: SubworkflowFeatureRequirement}
- {class: InlineJavascriptRequirement}
steps:
- id: step1
  in:
  - id: file1
    linkMerge: merge_nested
    source: [file1]
  out: [output]
  run:
    baseCommand: wc
    class: CommandLineTool
    inputs:
    - id: file1
      inputBinding: {}
      type: {items: File, type: array}
    outputs:
    - id: output
      outputBinding: {glob: output.txt, loadContents: true, outputEval: "${\n  var\
          \ s = self[0].contents.split(/\\r?\\n/);\n  return parseInt(s[s.length-2]);\n\
          }\n"}
      type: int
    requirements:
    - {class: InlineJavascriptRequirement}
    stdout: output.txt
