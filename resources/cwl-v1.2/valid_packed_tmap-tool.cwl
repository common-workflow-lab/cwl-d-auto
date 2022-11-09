arguments: [tmap, mapall]
baseCommand: python
class: CommandLineTool
cwlVersion: v1.2
hints:
- {class: DockerRequirement, dockerPull: python:2-slim}
inputs:
- {id: reads, type: File}
- id: stages
  inputBinding: {position: 1}
  type:
    items:
      fields:
      - inputBinding: {position: 0, prefix: stage, separate: false}
        name: stageId
        type: ['null', int]
      - inputBinding: {position: 1, prefix: -n}
        name: stageOption1
        type: ['null', boolean]
      - inputBinding: {position: 2}
        name: algos
        type:
          items:
          - fields:
            - inputBinding: {position: 0}
              name: algo
              type:
                name: JustMap1
                symbols: [map1]
                type: enum
            - inputBinding: {position: 2, prefix: --max-seq-length}
              name: maxSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --min-seq-length}
              name: minSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --seed-length}
              name: seedLength
              type: ['null', int]
            name: user_type_17
            type: record
          - fields:
            - inputBinding: {position: 0}
              name: algo
              type:
                name: JustMap2
                symbols: [map2]
                type: enum
            - inputBinding: {position: 2, prefix: --max-seq-length}
              name: maxSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --min-seq-length}
              name: minSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --max-seed-hits}
              name: maxSeedHits
              type: ['null', int]
            name: user_type_33
            type: record
          - fields:
            - inputBinding: {position: 0}
              name: algo
              type:
                name: JustMap3
                symbols: [map3]
                type: enum
            - inputBinding: {position: 2, prefix: --max-seq-length}
              name: maxSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --min-seq-length}
              name: minSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --fwd-search}
              name: fwdSearch
              type: ['null', boolean]
            name: user_type_49
            type: record
          - fields:
            - inputBinding: {position: 0}
              name: algo
              type:
                name: JustMap4
                symbols: [map4]
                type: enum
            - inputBinding: {position: 2, prefix: --max-seq-length}
              name: maxSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --min-seq-length}
              name: minSeqLen
              type: ['null', int]
            - inputBinding: {position: 2, prefix: --seed-step}
              name: seedStep
              type: ['null', int]
            name: user_type_65
            type: record
          type: array
      name: user_type_4
      type: record
    type: array
- default: {class: File, location: args.py}
  id: '#args.py'
  inputBinding: {position: -1}
  type: File
outputs:
- id: sam
  outputBinding: {glob: output.sam}
  type: ['null', File]
- id: args
  type: {items: string, type: array}
requirements:
- {class: InlineJavascriptRequirement}
