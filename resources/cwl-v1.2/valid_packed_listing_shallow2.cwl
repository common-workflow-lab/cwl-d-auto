baseCommand: 'true'
class: CommandLineTool
cwlVersion: v1.2
inputs:
- {id: d, loadListing: shallow_listing, type: Directory}
outputs:
- id: out
  outputBinding: {outputEval: '$(inputs.d.listing.length === 1 && inputs.d.listing[0].listing
      === undefined)'}
  type: boolean
requirements:
- {class: InlineJavascriptRequirement}
