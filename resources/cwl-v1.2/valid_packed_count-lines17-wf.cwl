class: Workflow
cwlVersion: v1.2
inputs:
- {id: file1, type: File}
outputs:
- {id: count_output, outputSource: step1/count_output, type: int}
requirements:
- {class: SubworkflowFeatureRequirement}
- {class: InlineJavascriptRequirement}
steps:
- id: step1
  in:
  - {id: file1, source: file1}
  out: [count_output]
  run:
    class: Workflow
    inputs:
    - {id: file1, type: File}
    outputs:
    - {id: count_output, outputSource: step2/output, type: int}
    requirements:
    - {class: SubworkflowFeatureRequirement}
    - {class: InlineJavascriptRequirement}
    steps:
    - id: step1
      in:
      - {id: file1, source: file1}
      out: [wc_output]
      run:
        class: Workflow
        inputs:
        - {id: file1, type: File}
        outputs:
        - {id: wc_output, outputSource: step1/output, type: File}
        requirements:
        - {class: SubworkflowFeatureRequirement}
        - {class: InlineJavascriptRequirement}
        steps:
        - id: step1
          in:
          - {id: file1, source: file1}
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
      - {id: file1, source: step1/wc_output}
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
