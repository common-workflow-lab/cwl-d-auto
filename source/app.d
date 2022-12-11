/**
 * Example of cwl-d-auto
 */
void main(string[] args)
{
	import std : enforce, exists, getopt, stderr;

	string cwlVersion = "v1.0";
	auto opts = args.getopt(
		"cwl-version", "CWL loader", &cwlVersion,
	);

	if (opts.helpWanted || args.length != 2)
	{
		import std : baseName, defaultGetoptFormatter, format, outdent, stdout;

        immutable baseMessage = format!(q"EOS
            A demonstration to use auto generated CWL parsers
            Usage: %s [options] [cwlfile]
EOS".outdent[0 .. $ - 1])(args[0].baseName);

        defaultGetoptFormatter(
            stdout.lockingTextWriter, baseMessage,
            opts.options, "%-*s %-*s%*s%s\x0a",
        );
        return;
 	}

	auto file = args[1];
	enforce(file.exists, "File not found");

	switch(cwlVersion)
	{
	case "v1.0":{
		import cwl.v1_0;
		import salad.resolver : absoluteURI;

		import dyaml : Node;
		import std : match, tryMatch, writefln;

		// Loading file
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

		// Convert CWL object to YAML node
		auto yamlNode = doc.match!(d => Node(d));
		break;
	}
	default:
		stderr.writefln!"Example is not yet prepared: %s"(cwlVersion);
		return;
	}
}
