baseCommand: [cat]
class: CommandLineTool
cwlVersion: v1.2
inputs:
- {id: dir1, type: Directory}
outputs:
- {id: output, type: stdout}
requirements:
- {class: InlineJavascriptRequirement}
stdin: $(inputs.dir1.listing[0].path)
