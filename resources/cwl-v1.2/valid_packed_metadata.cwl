$namespaces: {dct: http://purl.org/dc/terms/, foaf: http://xmlns.com/foaf/0.1/}
$schemas: [foaf.rdf, dcterms.rdf]
baseCommand: cat
class: CommandLineTool
cwlVersion: v1.2
dct:creator: {class: foaf:Person, foaf:mbox: mailto:peter.amstutz@curoverse.com, foaf:name: Peter
    Amstutz, id: http://orcid.org/0000-0003-3566-7705}
doc: Print the contents of a file to stdout using 'cat' running in a docker container.
hints:
  DockerRequirement: {dockerPull: debian:stretch-slim}
inputs:
- id: file1
  inputBinding: {position: 1}
  type: File
- id: numbering
  inputBinding: {position: 0, prefix: -n}
  type: ['null', boolean]
outputs: []
requirements:
- {class: InlineJavascriptRequirement}
