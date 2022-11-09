baseCommand: 'true'
class: CommandLineTool
cwlVersion: v1.2
inputs:
- {id: filelist, type: File}
outputs:
- id: filelist
  outputBinding: {glob: renamed-filelist.txt}
  type: File
requirements:
- class: InitialWorkDirRequirement
  listing:
  - {entry: $(inputs.filelist), entryname: renamed-filelist.txt}
- {class: InlineJavascriptRequirement}
