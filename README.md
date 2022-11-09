# cwl-d-auto

[![build](https://github.com/common-workflow-lab/cwl-d-auto/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/common-workflow-lab/cwl-d-auto/actions/) [![license](https://badgen.net/github/license/common-workflow-lab/cwl-d-auto)](https://github.com/common-workflow-lab/cwl-d-auto/blob/main/LICENSE)

Autogenerated classes for reading and writing CWL objects using the D language.

It integrates with [schema-salad-d](https://github.com/tom-tan/schema-salad-d) and provides the following features:

- Loading YAML files or nodes to generate corresponding D objects
- Storing D object for CWL to YAML nodes

## How is the parser generated?
It is generated with [schema-salad-tool](https://github.com/common-workflow-language/schema_salad) as shown below.

```console
$ schema-salad-tool --codegen dlang cwl-v1.0/v1.0/CommonWorkflowLanguage.yml --codegen-package cwl_d_auto.v1_0 --codegen-parser-info "CWL v1.0 parser generated with schema-salad-tool" > v1_0.d
```

- You can specify the package name via `--codegen-package`.
- You can add informative message into the generated package via `--codegen-parser-info`. It can be accessed via `cwl.v1_2.parserInfo`.

## How to use

See [source/app.d](source/app.d) for a concrete example.

```d
import cwl_d_auto.v1_0; // auto generated CWL parser

import salad.resolver : absoluteURI;

import dyaml : Node;
import std : match, tryMatch, writefln;

import salad.meta.parser : DocRootType = DocumentRootType, import_ = importFromURI;

// Loader for generated data structures
alias importFromURI = import_!(cwl_d_auto.v1_0);
// DocumentRootType is one of CommandLineTool, Workflow and ExpressionTool (implemented with std.sumtype.SumType)
alias DocumentRootType = DocRootType!(cwl_d_auto.v1_0);

///// Loading file

auto uri = file.absoluteURI;

// dispatch with std.sumtype.match for loaded object
auto doc = importFromURI(uri).match!(
	// typical case
	(DocumentRootType r) => r,
	// When loaded CWL has `$graph`, the result is DocumentRootType[]
	(DocumentRootType[] rs) => rs[0],
);

// use std.sumtype.tryMatch if you can assume the type of target object 
// The following `tryMatch` assumes `doc` is CLT or Workflow. Otherwise it throws an exception
auto classStr = doc.tryMatch!(
	(CommandLineTool clt) => "CommandLineTool",
	(Workflow wf) => "Workflow",
);
		
writefln!"%s is %s class."(uri, classStr);

///// Convert CWL object to YAML node
auto yamlNode = doc.match!(d => Node(d));
```

### How to run the example
The example just prints the document class of a given CWL document.

```console
$ dub run -- ./download-sra.cwl
...
file:///workspaces/cwl-d-auto/download-sra.cwl is CommandLineTool class.
```

## How to test
TODO: Add tests!

```console
$ dub test
```
