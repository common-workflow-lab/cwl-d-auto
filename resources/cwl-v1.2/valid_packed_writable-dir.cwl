arguments: [touch, emptyWritableDir/blurg]
class: CommandLineTool
cwlVersion: v1.2
inputs: []
outputs:
- id: out
  outputBinding: {glob: emptyWritableDir}
  type: Directory
requirements:
- {class: InlineJavascriptRequirement}
- class: InitialWorkDirRequirement
  listing:
  - {entry: "$({class: 'Directory', listing: []})", entryname: emptyWritableDir, writable: true}
