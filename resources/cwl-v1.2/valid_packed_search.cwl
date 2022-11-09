$graph:
- arguments:
  - {position: 1, valueFrom: input.txt}
  baseCommand: python
  class: CommandLineTool
  hints:
  - {class: DockerRequirement, dockerPull: python:2-slim}
  id: index
  inputs:
    file: File
    index.py:
      default: {class: File, location: index.py}
      inputBinding: {position: 0}
      type: File
    secondfile: File
  outputs:
    result:
      outputBinding: {glob: input.txt}
      secondaryFiles: [.idx1, ^.idx2, $(self.basename).idx3, '${ return self.basename+".idx4";
          }', '$({"path": self.path+".idx5", "class": "File"})', $(self.nameroot).idx6$(self.nameext),
        '${ return [self.basename+".idx7", inputs.secondfile]; }', _idx8]
      type: File
  requirements:
  - class: InitialWorkDirRequirement
    listing:
    - {entry: $(inputs.file), entryname: input.txt}
  - {class: InlineJavascriptRequirement}
- baseCommand: python
  class: CommandLineTool
  hints:
  - {class: DockerRequirement, dockerPull: python:2-slim}
  id: search
  inputs:
    file:
      inputBinding: {position: 1}
      secondaryFiles: [.idx1, ^.idx2, $(self.basename).idx3, '${ return self.basename+".idx4";
          }', $(self.nameroot).idx6$(self.nameext), '${ return [self.basename+".idx7"];
          }', _idx8]
      type: File
    search.py:
      default: {class: File, location: search.py}
      inputBinding: {position: 0}
      type: File
    term:
      inputBinding: {position: 2}
      type: string
  outputs:
    result:
      outputBinding: {glob: result.txt}
      type: File
  requirements:
  - {class: InlineJavascriptRequirement}
  stdout: result.txt
- class: Workflow
  id: main
  inputs: {infile: File, secondfile: File, term: string}
  outputs:
    indexedfile: {outputSource: index/result, type: File}
    outfile: {outputSource: search/result, type: File}
  steps:
    index:
      in: {file: infile, secondfile: secondfile}
      out: [result]
      run: '#index'
    search:
      in: {file: index/result, term: term}
      out: [result]
      run: '#search'
cwlVersion: v1.2
