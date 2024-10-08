/**
 * CWL v1.2 parser generated with schema-salad-tool
 * 
 * This module was generated using schema-salad code generator.
 * 
 * The embedded document is subject to the license of the original schema.
 * 
 * License: Apache-2.0
 * Date: 2024-09-26
 */
module cwl.v1_2;

import salad.meta.impl : genBody_;
import salad.meta.parser : import_ = importFromURI;
import salad.meta.uda : defaultValue, documentRoot, id, idMap, link, LinkResolver, secondaryFilesDSL, typeDSL;
import salad.primitives : EnumSchemaBase, MapSchemaBase, RecordSchemaBase, UnionSchemaBase;
import salad.type : None, Union;

/// parser information
enum parserInfo = "CWL v1.2 parser generated with schema-salad-tool";

// Modified until the following pull request is merged
// See_Also: https://github.com/common-workflow-language/schema_salad/pull/861
enum saladVersion = "v1.3";

mixin template genBody()
{
    mixin genBody_!saladVersion;
}

/**
 * Names of salad data types (based on Avro schema declarations).
 * 
 * Refer to the [Avro schema declaration documentation](https://avro.apache.org/docs/current/spec.html#schemas) for
 * detailed information.
 * 
 * null: no value
 * boolean: a binary value
 * int: 32-bit signed integer
 * long: 64-bit signed integer
 * float: single precision (32-bit) IEEE 754 floating-point number
 * double: double precision (64-bit) IEEE 754 floating-point number
 * string: Unicode character sequence
 */
class PrimitiveType : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "null", ///
        s1 = "boolean", ///
        s2 = "int", ///
        s3 = "long", ///
        s4 = "float", ///
        s5 = "double", ///
        s6 = "string", ///
    }

    Symbol value;

    mixin genBody;
}

///
public import salad.primitives : Any;

/**
 * A field of a record.
 */
class RecordField : RecordSchemaBase
{
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The name of the field
     */
    @id string name_;
    /**
     * The field type. If it is an array, it indicates
     * that the field type is a union type of its elements.
     * Its elements may be duplicated.
     */
    @typeDSL Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string, Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string)[]) type_;

    mixin genBody;
}

///
class RecordSchema : RecordSchemaBase
{
    /**
     * Defines the fields of the record.
     */
    @idMap("name", "type") Union!(None, RecordField[]) fields_;
    /**
     * Must be `record`
     */
    static immutable type_ = "record";

    mixin genBody;
}

/**
 * Define an enumerated type.
 */
class EnumSchema : RecordSchemaBase
{
    ///
    @id Union!(None, string) name_;
    /**
     * Defines the set of valid symbols.
     */
    @link(LinkResolver.id) string[] symbols_;
    /**
     * Must be `enum`
     */
    static immutable type_ = "enum";

    mixin genBody;
}

///
class ArraySchema : RecordSchemaBase
{
    /**
     * Defines the type of the array elements.
     */
    Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string, Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string)[]) items_;
    /**
     * Must be `array`
     */
    static immutable type_ = "array";

    mixin genBody;
}

///
class MapSchema : RecordSchemaBase
{
    /**
     * Must be `map`
     */
    static immutable type_ = "map";
    /**
     * Defines the type of the map elements.
     */
    Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string, Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string)[]) values_;

    mixin genBody;
}

///
class UnionSchema : RecordSchemaBase
{
    /**
     * Defines the type of the union elements.
     */
    Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string, Union!(PrimitiveType, RecordSchema, EnumSchema, ArraySchema, MapSchema, UnionSchema, string)[]) names_;
    /**
     * Must be `union`
     */
    static immutable type_ = "union";

    mixin genBody;
}

/**
 * Extends primitive types with the concept of a file and directory as a builtin type.
 * File: A File object
 * Directory: A Directory object
 */
class CWLType : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "null", ///
        s1 = "boolean", ///
        s2 = "int", ///
        s3 = "long", ///
        s4 = "float", ///
        s5 = "double", ///
        s6 = "string", ///
        s7 = "File", ///
        s8 = "Directory", ///
    }

    Symbol value;

    mixin genBody;
}

///
class CWLArraySchema : RecordSchemaBase
{
    /**
     * Defines the type of the array elements.
     */
    Union!(PrimitiveType, CWLRecordSchema, EnumSchema, CWLArraySchema, string, Union!(PrimitiveType, CWLRecordSchema, EnumSchema, CWLArraySchema, string)[]) items_;
    /**
     * Must be `array`
     */
    static immutable type_ = "array";

    mixin genBody;
}

///
class CWLRecordField : RecordSchemaBase
{
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The name of the field
     */
    @id string name_;
    /**
     * The field type
     */
    @typeDSL Union!(PrimitiveType, CWLRecordSchema, EnumSchema, CWLArraySchema, string, Union!(PrimitiveType, CWLRecordSchema, EnumSchema, CWLArraySchema, string)[]) type_;

    mixin genBody;
}

///
class CWLRecordSchema : RecordSchemaBase
{
    /**
     * Defines the fields of the record.
     */
    @idMap("name", "type") Union!(None, CWLRecordField[]) fields_;
    /**
     * Must be `record`
     */
    static immutable type_ = "record";

    mixin genBody;
}

/**
 * Represents a file (or group of files when `secondaryFiles` is provided) that
 * will be accessible by tools using standard POSIX file system call API such as
 * open(2) and read(2).
 * 
 * Files are represented as objects with `class` of `File`.  File objects have
 * a number of properties that provide metadata about the file.
 * 
 * The `location` property of a File is a IRI that uniquely identifies the
 * file.  Implementations must support the `file://` IRI scheme and may support
 * other schemes such as `http://` and `https://`.  The value of `location` may also be a
 * relative reference, in which case it must be resolved relative to the IRI
 * of the document it appears in.  Alternately to `location`, implementations
 * must also accept the `path` property on File, which must be a filesystem
 * path available on the same host as the CWL runner (for inputs) or the
 * runtime environment of a command line tool execution (for command line tool
 * outputs).
 * 
 * If no `location` or `path` is specified, a file object must specify
 * `contents` with the UTF-8 text content of the file.  This is a "file
 * literal".  File literals do not correspond to external resources, but are
 * created on disk with `contents` with when needed for executing a tool.
 * Where appropriate, expressions can return file literals to define new files
 * on a runtime.  The maximum size of `contents` is 64 kilobytes.
 * 
 * The `basename` property defines the filename on disk where the file is
 * staged.  This may differ from the resource name.  If not provided,
 * `basename` must be computed from the last path part of `location` and made
 * available to expressions.
 * 
 * The `secondaryFiles` property is a list of File or Directory objects that
 * must be staged in the same directory as the primary file.  It is an error
 * for file names to be duplicated in `secondaryFiles`.
 * 
 * The `size` property is the size in bytes of the File.  It must be computed
 * from the resource and made available to expressions.  The `checksum` field
 * contains a cryptographic hash of the file content for use it verifying file
 * contents.  Implementations may, at user option, enable or disable
 * computation of the `checksum` field for performance or other reasons.
 * However, the ability to compute output checksums is required to pass the
 * CWL conformance test suite.
 * 
 * When executing a CommandLineTool, the files and secondary files may be
 * staged to an arbitrary directory, but must use the value of `basename` for
 * the filename.  The `path` property must be file path in the context of the
 * tool execution runtime (local to the compute node, or within the executing
 * container).  All computed properties should be available to expressions.
 * File literals also must be staged and `path` must be set.
 * 
 * When collecting CommandLineTool outputs, `glob` matching returns file paths
 * (with the `path` property) and the derived properties. This can all be
 * modified by `outputEval`.  Alternately, if the file `cwl.output.json` is
 * present in the output, `outputBinding` is ignored.
 * 
 * File objects in the output must provide either a `location` IRI or a `path`
 * property in the context of the tool execution runtime (local to the compute
 * node, or within the executing container).
 * 
 * When evaluating an ExpressionTool, file objects must be referenced via
 * `location` (the expression tool does not have access to files on disk so
 * `path` is meaningless) or as file literals.  It is legal to return a file
 * object with an existing `location` but a different `basename`.  The
 * `loadContents` field of ExpressionTool inputs behaves the same as on
 * CommandLineTool inputs, however it is not meaningful on the outputs.
 * 
 * An ExpressionTool may forward file references from input to output by using
 * the same value for `location`.
 */
class File : RecordSchemaBase
{
    /**
     * Must be `File` to indicate this object describes a file.
     */
    static immutable class_ = "File";
    /**
     * An IRI that identifies the file resource.  This may be a relative
     * reference, in which case it must be resolved using the base IRI of the
     * document.  The location may refer to a local or remote resource; the
     * implementation must use the IRI to retrieve file content.  If an
     * implementation is unable to retrieve the file content stored at a
     * remote resource (due to unsupported protocol, access denied, or other
     * issue) it must signal an error.
     * 
     * If the `location` field is not provided, the `contents` field must be
     * provided.  The implementation must assign a unique identifier for
     * the `location` field.
     * 
     * If the `path` field is provided but the `location` field is not, an
     * implementation may assign the value of the `path` field to `location`,
     * then follow the rules above.
     */
    @link() Union!(None, string) location_;
    /**
     * The local host path where the File is available when a CommandLineTool is
     * executed.  This field must be set by the implementation.  The final
     * path component must match the value of `basename`.  This field
     * must not be used in any other context.  The command line tool being
     * executed must be able to access the file at `path` using the POSIX
     * `open(2)` syscall.
     * 
     * As a special case, if the `path` field is provided but the `location`
     * field is not, an implementation may assign the value of the `path`
     * field to `location`, and remove the `path` field.
     * 
     * If the `path` contains [POSIX shell metacharacters](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02)
     * (`|`,`&`, `;`, `<`, `>`, `$(LPAREN)`,`$(RPAREN)`, `$`,`` ` ``, `\`, `"`, `'`,
     * `<space>`, `<tab>`, and `<newline>`) or characters
     * [not allowed](http://www.iana.org/assignments/idna-tables-6.3.0/idna-tables-6.3.0.xhtml)
     * for [Internationalized Domain Names for Applications](https://tools.ietf.org/html/rfc6452)
     * then implementations may terminate the process with a
     * `permanentFailure`.
     */
    @link() Union!(None, string) path_;
    /**
     * The base name of the file, that is, the name of the file without any
     * leading directory path.  The base name must not contain a slash `/`.
     * 
     * If not provided, the implementation must set this field based on the
     * `location` field by taking the final path component after parsing
     * `location` as an IRI.  If `basename` is provided, it is not required to
     * match the value from `location`.
     * 
     * When this file is made available to a CommandLineTool, it must be named
     * with `basename`, i.e. the final component of the `path` field must match
     * `basename`.
     */
    Union!(None, string) basename_;
    /**
     * The name of the directory containing file, that is, the path leading up
     * to the final slash in the path such that `dirname + '/' + basename ==
     * path`.
     * 
     * The implementation must set this field based on the value of `path`
     * prior to evaluating parameter references or expressions in a
     * CommandLineTool document.  This field must not be used in any other
     * context.
     */
    Union!(None, string) dirname_;
    /**
     * The basename root such that `nameroot + nameext == basename`, and
     * `nameext` is empty or begins with a period and contains at most one
     * period.  For the purposes of path splitting leading periods on the
     * basename are ignored; a basename of `.cshrc` will have a nameroot of
     * `.cshrc`.
     * 
     * The implementation must set this field automatically based on the value
     * of `basename` prior to evaluating parameter references or expressions.
     */
    Union!(None, string) nameroot_;
    /**
     * The basename extension such that `nameroot + nameext == basename`, and
     * `nameext` is empty or begins with a period and contains at most one
     * period.  Leading periods on the basename are ignored; a basename of
     * `.cshrc` will have an empty `nameext`.
     * 
     * The implementation must set this field automatically based on the value
     * of `basename` prior to evaluating parameter references or expressions.
     */
    Union!(None, string) nameext_;
    /**
     * Optional hash code for validating file integrity.  Currently, must be in the form
     * "sha1$ + hexadecimal string" using the SHA-1 algorithm.
     */
    Union!(None, string) checksum_;
    /**
     * Optional file size (in bytes)
     */
    Union!(None, int, long) size_;
    /**
     * A list of additional files or directories that are associated with the
     * primary file and must be transferred alongside the primary file.
     * Examples include indexes of the primary file, or external references
     * which must be included when loading primary document.  A file object
     * listed in `secondaryFiles` may itself include `secondaryFiles` for
     * which the same rules apply.
     */
    @secondaryFilesDSL Union!(None, Union!(File, Directory)[]) secondaryFiles_;
    /**
     * The format of the file: this must be an IRI of a concept node that
     * represents the file format, preferably defined within an ontology.
     * If no ontology is available, file formats may be tested by exact match.
     * 
     * Reasoning about format compatibility must be done by checking that an
     * input file format is the same, `owl:equivalentClass` or
     * `rdfs:subClassOf` the format required by the input parameter.
     * `owl:equivalentClass` is transitive with `rdfs:subClassOf`, e.g. if
     * `<B> owl:equivalentClass <C>` and `<B> owl:subclassOf <A>` then infer
     * `<C> owl:subclassOf <A>`.
     * 
     * File format ontologies may be provided in the "$schemas" metadata at the
     * root of the document.  If no ontologies are specified in `$schemas`, the
     * runtime may perform exact file format matches.
     */
    @link(LinkResolver.id) Union!(None, string) format_;
    /**
     * File contents literal.
     * 
     * If neither `location` nor `path` is provided, `contents` must be
     * non-null.  The implementation must assign a unique identifier for the
     * `location` field.  When the file is staged as input to CommandLineTool,
     * the value of `contents` must be written to a file.
     * 
     * If `contents` is set as a result of a Javascript expression,
     * an `entry` in `InitialWorkDirRequirement`, or read in from
     * `cwl.output.json`, there is no specified upper limit on the
     * size of `contents`.  Implementations may have practical limits
     * on the size of `contents` based on memory and storage
     * available to the workflow runner or other factors.
     * 
     * If the `loadContents` field of an `InputParameter` or
     * `OutputParameter` is true, and the input or output File object
     * `location` is valid, the file must be a UTF-8 text file 64 KiB
     * or smaller, and the implementation must read the entire
     * contents of the file and place it in the `contents` field.  If
     * the size of the file is greater than 64 KiB, the
     * implementation must raise a fatal error.
     */
    Union!(None, string) contents_;

    mixin genBody;
}

/**
 * Represents a directory to present to a command line tool.
 * 
 * Directories are represented as objects with `class` of `Directory`.  Directory objects have
 * a number of properties that provide metadata about the directory.
 * 
 * The `location` property of a Directory is a IRI that uniquely identifies
 * the directory.  Implementations must support the file:// IRI scheme and may
 * support other schemes such as http://.  Alternately to `location`,
 * implementations must also accept the `path` property on Directory, which
 * must be a filesystem path available on the same host as the CWL runner (for
 * inputs) or the runtime environment of a command line tool execution (for
 * command line tool outputs).
 * 
 * A Directory object may have a `listing` field.  This is a list of File and
 * Directory objects that are contained in the Directory.  For each entry in
 * `listing`, the `basename` property defines the name of the File or
 * Subdirectory when staged to disk.  If `listing` is not provided, the
 * implementation must have some way of fetching the Directory listing at
 * runtime based on the `location` field.
 * 
 * If a Directory does not have `location`, it is a Directory literal.  A
 * Directory literal must provide `listing`.  Directory literals must be
 * created on disk at runtime as needed.
 * 
 * The resources in a Directory literal do not need to have any implied
 * relationship in their `location`.  For example, a Directory listing may
 * contain two files located on different hosts.  It is the responsibility of
 * the runtime to ensure that those files are staged to disk appropriately.
 * Secondary files associated with files in `listing` must also be staged to
 * the same Directory.
 * 
 * When executing a CommandLineTool, Directories must be recursively staged
 * first and have local values of `path` assigned.
 * 
 * Directory objects in CommandLineTool output must provide either a
 * `location` IRI or a `path` property in the context of the tool execution
 * runtime (local to the compute node, or within the executing container).
 * 
 * An ExpressionTool may forward file references from input to output by using
 * the same value for `location`.
 * 
 * Name conflicts (the same `basename` appearing multiple times in `listing`
 * or in any entry in `secondaryFiles` in the listing) is a fatal error.
 */
class Directory : RecordSchemaBase
{
    /**
     * Must be `Directory` to indicate this object describes a Directory.
     */
    static immutable class_ = "Directory";
    /**
     * An IRI that identifies the directory resource.  This may be a relative
     * reference, in which case it must be resolved using the base IRI of the
     * document.  The location may refer to a local or remote resource.  If
     * the `listing` field is not set, the implementation must use the
     * location IRI to retrieve directory listing.  If an implementation is
     * unable to retrieve the directory listing stored at a remote resource (due to
     * unsupported protocol, access denied, or other issue) it must signal an
     * error.
     * 
     * If the `location` field is not provided, the `listing` field must be
     * provided.  The implementation must assign a unique identifier for
     * the `location` field.
     * 
     * If the `path` field is provided but the `location` field is not, an
     * implementation may assign the value of the `path` field to `location`,
     * then follow the rules above.
     */
    @link() Union!(None, string) location_;
    /**
     * The local path where the Directory is made available prior to executing a
     * CommandLineTool.  This must be set by the implementation.  This field
     * must not be used in any other context.  The command line tool being
     * executed must be able to access the directory at `path` using the POSIX
     * `opendir(2)` syscall.
     * 
     * If the `path` contains [POSIX shell metacharacters](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02)
     * (`|`,`&`, `;`, `<`, `>`, `$(LPAREN)`,`$(RPAREN)`, `$`,`` ` ``, `\`, `"`, `'`,
     * `<space>`, `<tab>`, and `<newline>`) or characters
     * [not allowed](http://www.iana.org/assignments/idna-tables-6.3.0/idna-tables-6.3.0.xhtml)
     * for [Internationalized Domain Names for Applications](https://tools.ietf.org/html/rfc6452)
     * then implementations may terminate the process with a
     * `permanentFailure`.
     */
    @link() Union!(None, string) path_;
    /**
     * The base name of the directory, that is, the name of the file without any
     * leading directory path.  The base name must not contain a slash `/`.
     * 
     * If not provided, the implementation must set this field based on the
     * `location` field by taking the final path component after parsing
     * `location` as an IRI.  If `basename` is provided, it is not required to
     * match the value from `location`.
     * 
     * When this file is made available to a CommandLineTool, it must be named
     * with `basename`, i.e. the final component of the `path` field must match
     * `basename`.
     */
    Union!(None, string) basename_;
    /**
     * List of files or subdirectories contained in this directory.  The name
     * of each file or subdirectory is determined by the `basename` field of
     * each `File` or `Directory` object.  It is an error if a `File` shares a
     * `basename` with any other entry in `listing`.  If two or more
     * `Directory` object share the same `basename`, this must be treated as
     * equivalent to a single subdirectory with the listings recursively
     * merged.
     */
    Union!(None, Union!(File, Directory)[]) listing_;

    mixin genBody;
}

/**
 * Generic type representing a valid CWL object. It is used to represent
 * `default` values passed to CWL `InputParameter` and `WorkflowStepInput`
 * record fields.
 */
class CWLObjectType : UnionSchemaBase
{
    Union!(bool, int, long, float, double, string, File, Directory, Union!(None, CWLObjectType)[], CWLObjectType[string]) payload;

    mixin genBody;
}

/**
 * Type representing a valid CWL input file as a `map<string, union<array<ProcessRequirement>, CWLObjectType>>`.
 */
class CWLInputFile : MapSchemaBase
{
    Union!(Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement)[], CWLObjectType)[string] payload;

    mixin genBody;
}

/**
 * Version symbols for published CWL document versions.
 */
class CWLVersion : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "draft-2", ///
        s1 = "draft-3.dev1", ///
        s2 = "draft-3.dev2", ///
        s3 = "draft-3.dev3", ///
        s4 = "draft-3.dev4", ///
        s5 = "draft-3.dev5", ///
        s6 = "draft-3", ///
        s7 = "draft-4.dev1", ///
        s8 = "draft-4.dev2", ///
        s9 = "draft-4.dev3", ///
        s10 = "v1.0.dev4", ///
        s11 = "v1.0", ///
        s12 = "v1.1.0-dev1", ///
        s13 = "v1.1", ///
        s14 = "v1.2.0-dev1", ///
        s15 = "v1.2.0-dev2", ///
        s16 = "v1.2.0-dev3", ///
        s17 = "v1.2.0-dev4", ///
        s18 = "v1.2.0-dev5", ///
        s19 = "v1.2", ///
    }

    Symbol value;

    mixin genBody;
}

/**
 * Specify the desired behavior for loading the `listing` field of
 * a Directory object for use by expressions.
 * 
 * no_listing: Do not load the directory listing.
 * shallow_listing: Only load the top level listing, do not recurse into subdirectories.
 * deep_listing: Load the directory listing and recursively load all subdirectories as well.
 */
class LoadListingEnum : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "no_listing", ///
        s1 = "shallow_listing", ///
        s2 = "deep_listing", ///
    }

    Symbol value;

    mixin genBody;
}

///
public import salad.primitives : Expression;

///
class InputBinding : RecordSchemaBase
{
    /**
     * Use of `loadContents` in `InputBinding` is deprecated.
     * Preserved for v1.0 backwards compatibility.  Will be removed in
     * CWL v2.0.  Use `InputParameter.loadContents` instead.
     */
    Union!(None, bool) loadContents_;

    mixin genBody;
}

///
class InputRecordField : RecordSchemaBase
{
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The name of the field
     */
    @id string name_;
    /**
     * The field type
     */
    @typeDSL Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string, Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string)[]) type_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This must be one or more IRIs of concept nodes
     * that represents file formats which are allowed as input to this
     * parameter, preferably defined within an ontology.  If no ontology is
     * available, file formats may be tested by exact match.
     */
    @link(LinkResolver.id) Union!(None, string, string[], Expression) format_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * If true, the file (or each file in the array) must be a UTF-8
     * text file 64 KiB or smaller, and the implementation must read
     * the entire contents of the file (or file array) and place it
     * in the `contents` field of the File object for use by
     * expressions.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     */
    Union!(None, bool) loadContents_;
    /**
     * Only valid when `type: Directory` or is an array of `items: Directory`.
     * 
     * Specify the desired behavior for loading the `listing` field of
     * a Directory object for use by expressions.
     * 
     * The order of precedence for loadListing is:
     * 
     *   1. `loadListing` on an individual parameter
     *   2. Inherited from `LoadListingRequirement`
     *   3. By default: `no_listing`
     */
    Union!(None, LoadListingEnum) loadListing_;

    mixin genBody;
}

///
class InputRecordSchema : RecordSchemaBase
{
    /**
     * Defines the fields of the record.
     */
    @idMap("name", "type") Union!(None, InputRecordField[]) fields_;
    /**
     * Must be `record`
     */
    static immutable type_ = "record";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;

    mixin genBody;
}

///
class InputEnumSchema : RecordSchemaBase
{
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;
    /**
     * Defines the set of valid symbols.
     */
    @link(LinkResolver.id) string[] symbols_;
    /**
     * Must be `enum`
     */
    static immutable type_ = "enum";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;

    mixin genBody;
}

///
class InputArraySchema : RecordSchemaBase
{
    /**
     * Defines the type of the array elements.
     */
    Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string, Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string)[]) items_;
    /**
     * Must be `array`
     */
    static immutable type_ = "array";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;

    mixin genBody;
}

///
class OutputRecordField : RecordSchemaBase
{
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The name of the field
     */
    @id string name_;
    /**
     * The field type
     */
    @typeDSL Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string, Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string)[]) type_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to the output
     * File object.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;

    mixin genBody;
}

///
class OutputRecordSchema : RecordSchemaBase
{
    /**
     * Defines the fields of the record.
     */
    @idMap("name", "type") Union!(None, OutputRecordField[]) fields_;
    /**
     * Must be `record`
     */
    static immutable type_ = "record";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;

    mixin genBody;
}

///
class OutputEnumSchema : RecordSchemaBase
{
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;
    /**
     * Defines the set of valid symbols.
     */
    @link(LinkResolver.id) string[] symbols_;
    /**
     * Must be `enum`
     */
    static immutable type_ = "enum";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;

    mixin genBody;
}

///
class OutputArraySchema : RecordSchemaBase
{
    /**
     * Defines the type of the array elements.
     */
    Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string, Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string)[]) items_;
    /**
     * Must be `array`
     */
    static immutable type_ = "array";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;

    mixin genBody;
}

/**
 * Indicates that the workflow platform must support inline Javascript expressions.
 * If this requirement is not present, the workflow platform must not perform expression
 * interpolation.
 */
class InlineJavascriptRequirement : RecordSchemaBase
{
    /**
     * Always 'InlineJavascriptRequirement'
     */
    static immutable class_ = "InlineJavascriptRequirement";
    /**
     * Additional code fragments that will also be inserted
     * before executing the expression code.  Allows for function definitions that may
     * be called from CWL expressions.
     */
    Union!(None, string[]) expressionLib_;

    mixin genBody;
}

/**
 * This field consists of an array of type definitions which must be used when
 * interpreting the `inputs` and `outputs` fields.  When a `type` field
 * contains a IRI, the implementation must check if the type is defined in
 * `schemaDefs` and use that definition.  If the type is not found in
 * `schemaDefs`, it is an error.  The entries in `schemaDefs` must be
 * processed in the order listed such that later schema definitions may refer
 * to earlier schema definitions.
 * 
 * - **Type definitions are allowed for `enum` and `record` types only.**
 * - Type definitions may be shared by defining them in a file and then
 *   `$include`-ing them in the `types` field.
 * - A file can contain a list of type definitions
 */
class SchemaDefRequirement : RecordSchemaBase
{
    /**
     * Always 'SchemaDefRequirement'
     */
    static immutable class_ = "SchemaDefRequirement";
    /**
     * The list of type definitions.
     */
    Union!(CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema)[] types_;

    mixin genBody;
}

/**
 * Secondary files are specified using the following micro-DSL for secondary files:
 * 
 * * If the value is a string, it is transformed to an object with two fields
 *   `pattern` and `required`
 * * By default, the value of `required` is `null`
 *   (this indicates default behavior, which may be based on the context)
 * * If the value ends with a question mark `?` the question mark is
 *   stripped off and the value of the field `required` is set to `False`
 * * The remaining value is assigned to the field `pattern`
 * 
 * For implementation details and examples, please see
 * [this section](SchemaSalad.html#Domain_Specific_Language_for_secondary_files)
 * in the Schema Salad specification.
 */
class SecondaryFileSchema : RecordSchemaBase
{
    /**
     * Provides a pattern or expression specifying files or directories that
     * should be included alongside the primary file.
     * 
     * If the value is an expression, the value of `self` in the
     * expression must be the primary input or output File object to
     * which this binding applies.  The `basename`, `nameroot` and
     * `nameext` fields must be present in `self`.  For
     * `CommandLineTool` inputs the `location` field must also be
     * present.  For `CommandLineTool` outputs the `path` field must
     * also be present.  If secondary files were included on an input
     * File object as part of the Process invocation, they must also
     * be present in `secondaryFiles` on `self`.
     * 
     * The expression must return either: a filename string relative
     * to the path to the primary File, a File or Directory object
     * (`class: File` or `class: Directory`) with either `location`
     * (for inputs) or `path` (for outputs) and `basename` fields
     * set, or an array consisting of strings or File or Directory
     * objects as previously described.
     * 
     * It is legal to use `location` from a File or Directory object
     * passed in as input, including `location` from secondary files
     * on `self`.  If an expression returns a File object with the
     * same `location` but a different `basename` as a secondary file
     * that was passed in, the expression result takes precedence.
     * Setting the basename with an expression this way affects the
     * `path` where the secondary file will be staged to in the
     * CommandLineTool.
     * 
     * The expression may return "null" in which case there is no
     * secondary file from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable
     * tool descriptions should treat `location` as an
     * [opaque identifier](#opaque-strings) and avoid constructing new
     * values from `location`, but should construct relative references
     * using `basename` or `nameroot` instead, or propagate `location`
     * from defined inputs.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    Union!(string, Expression) pattern_;
    /**
     * An implementation must not fail workflow execution if `required` is
     * set to `false` and the expected secondary file does not exist.
     * Default value for `required` field is `true` for secondary files on
     * input and `false` for secondary files on output.
     */
    Union!(None, bool, Expression) required_;

    mixin genBody;
}

/**
 * Specify the desired behavior for loading the `listing` field of
 * a Directory object for use by expressions.
 */
class LoadListingRequirement : RecordSchemaBase
{
    /**
     * Always 'LoadListingRequirement'
     */
    static immutable class_ = "LoadListingRequirement";
    ///
    Union!(None, LoadListingEnum) loadListing_;

    mixin genBody;
}

/**
 * Define an environment variable that will be set in the runtime environment
 * by the workflow platform when executing the command line tool.  May be the
 * result of executing an expression, such as getting a parameter from input.
 */
class EnvironmentDef : RecordSchemaBase
{
    /**
     * The environment variable name
     */
    string envName_;
    /**
     * The environment variable value
     */
    Union!(string, Expression) envValue_;

    mixin genBody;
}

/**
 * 
 * When listed under `inputBinding` in the input schema, the term
 * "value" refers to the corresponding value in the input object.  For
 * binding objects listed in `CommandLineTool.arguments`, the term "value"
 * refers to the effective value after evaluating `valueFrom`.
 * 
 * The binding behavior when building the command line depends on the data
 * type of the value.  If there is a mismatch between the type described by
 * the input schema and the effective value, such as resulting from an
 * expression evaluation, an implementation must use the data type of the
 * effective value.
 * 
 *   - **string**: Add `prefix` and the string to the command line.
 * 
 *   - **number**: Add `prefix` and decimal representation to command line.
 * 
 *   - **boolean**: If true, add `prefix` to the command line.  If false, add
 *       nothing.
 * 
 *   - **File**: Add `prefix` and the value of
 *     [`File.path`](#File) to the command line.
 * 
 *   - **Directory**: Add `prefix` and the value of
 *     [`Directory.path`](#Directory) to the command line.
 * 
 *   - **array**: If `itemSeparator` is specified, add `prefix` and the join
 *       the array into a single string with `itemSeparator` separating the
 *       items.  Otherwise, first add `prefix`, then recursively process
 *       individual elements.
 *       If the array is empty, it does not add anything to command line.
 * 
 *   - **object**: Add `prefix` only, and recursively add object fields for
 *       which `inputBinding` is specified.
 * 
 *   - **null**: Add nothing.
 */
class CommandLineBinding : RecordSchemaBase
{
    /**
     * Use of `loadContents` in `InputBinding` is deprecated.
     * Preserved for v1.0 backwards compatibility.  Will be removed in
     * CWL v2.0.  Use `InputParameter.loadContents` instead.
     */
    Union!(None, bool) loadContents_;
    /**
     * The sorting key.  Default position is 0. If a [CWL Parameter Reference](#Parameter_references)
     * or [CWL Expression](#Expressions_(Optional)) is used and if the
     * inputBinding is associated with an input parameter, then the value of
     * `self` will be the value of the input parameter.  Input parameter
     * defaults (as specified by the `InputParameter.default` field) must be
     * applied before evaluating the expression. Expressions must return a
     * single value of type int or a null.
     */
    @defaultValue(q"<0>") Union!(int, Expression) position_;
    /**
     * Command line prefix to add before the value.
     */
    Union!(None, string) prefix_;
    /**
     * If true (default), then the prefix and value must be added as separate
     * command line arguments; if false, prefix and value must be concatenated
     * into a single command line argument.
     */
    @defaultValue(q"<true>") bool separate_;
    /**
     * Join the array elements into a single string with the elements
     * separated by `itemSeparator`.
     */
    Union!(None, string) itemSeparator_;
    /**
     * If `valueFrom` is a constant string value, use this as the value and
     * apply the binding rules above.
     * 
     * If `valueFrom` is an expression, evaluate the expression to yield the
     * actual value to use to build the command line and apply the binding
     * rules above.  If the inputBinding is associated with an input
     * parameter, the value of `self` in the expression will be the value of
     * the input parameter.  Input parameter defaults (as specified by the
     * `InputParameter.default` field) must be applied before evaluating the
     * expression.
     * 
     * If the value of the associated input parameter is `null`, `valueFrom` is
     * not evaluated and nothing is added to the command line.
     * 
     * When a binding is part of the `CommandLineTool.arguments` field,
     * the `valueFrom` field is required.
     */
    Union!(None, string, Expression) valueFrom_;
    /**
     * If `ShellCommandRequirement` is in the requirements for the current command,
     * this controls whether the value is quoted on the command line (default is true).
     * Use `shellQuote: false` to inject metacharacters for operations such as pipes.
     * 
     * If `shellQuote` is true or not provided, the implementation must not
     * permit interpretation of any shell metacharacters or directives.
     */
    @defaultValue(q"<true>") bool shellQuote_;

    mixin genBody;
}

/**
 * Describes how to generate an output parameter based on the files produced
 * by a CommandLineTool.
 * 
 * The output parameter value is generated by applying these operations in the
 * following order:
 * 
 *   - glob
 *   - loadContents
 *   - outputEval
 *   - secondaryFiles
 */
class CommandOutputBinding : RecordSchemaBase
{
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * If true, the file (or each file in the array) must be a UTF-8
     * text file 64 KiB or smaller, and the implementation must read
     * the entire contents of the file (or file array) and place it
     * in the `contents` field of the File object for use by
     * expressions.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     */
    Union!(None, bool) loadContents_;
    /**
     * Only valid when `type: Directory` or is an array of `items: Directory`.
     * 
     * Specify the desired behavior for loading the `listing` field of
     * a Directory object for use by expressions.
     * 
     * The order of precedence for loadListing is:
     * 
     *   1. `loadListing` on an individual parameter
     *   2. Inherited from `LoadListingRequirement`
     *   3. By default: `no_listing`
     */
    Union!(None, LoadListingEnum) loadListing_;
    /**
     * Find files or directories relative to the output directory, using POSIX
     * glob(3) pathname matching.  If an array is provided, find files or
     * directories that match any pattern in the array.  If an expression is
     * provided, the expression must return a string or an array of strings,
     * which will then be evaluated as one or more glob patterns.  Must only
     * match and return files/directories which actually exist.
     * 
     * If the value of glob is a relative path pattern (does not
     * begin with a slash '/') then it is resolved relative to the
     * output directory.  If the value of the glob is an absolute
     * path pattern (it does begin with a slash '/') then it must
     * refer to a path within the output directory.  It is an error
     * if any glob resolves to a path outside the output directory.
     * Specifically this means globs that resolve to paths outside the output
     * directory are illegal.
     * 
     * A glob may match a path within the output directory which is
     * actually a symlink to another file.  In this case, the
     * expected behavior is for the resulting File/Directory object to take the
     * `basename` (and corresponding `nameroot` and `nameext`) of the
     * symlink.  The `location` of the File/Directory is implementation
     * dependent, but logically the File/Directory should have the same content
     * as the symlink target.  Platforms may stage output files/directories to
     * cloud storage that lack the concept of a symlink.  In
     * this case file content and directories may be duplicated, or (to avoid
     * duplication) the File/Directory `location` may refer to the symlink
     * target.
     * 
     * It is an error if a symlink in the output directory (or any
     * symlink in a chain of links) refers to any file or directory
     * that is not under an input or output directory.
     * 
     * Implementations may shut down a container before globbing
     * output, so globs and expressions must not assume access to the
     * container filesystem except for declared input and output.
     */
    Union!(None, string, Expression, string[]) glob_;
    /**
     * Evaluate an expression to generate the output value.  If
     * `glob` was specified, the value of `self` must be an array
     * containing file objects that were matched.  If no files were
     * matched, `self` must be a zero length array; if a single file
     * was matched, the value of `self` is an array of a single
     * element.  The exit code of the process is
     * available in the expression as `runtime.exitCode`.
     * 
     * Additionally, if `loadContents` is true, the file must be a
     * UTF-8 text file 64 KiB or smaller, and the implementation must
     * read the entire contents of the file (or file array) and place
     * it in the `contents` field of the File object for use in
     * `outputEval`.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     * 
     * If a tool needs to return a large amount of structured data to
     * the workflow, loading the output object from `cwl.output.json`
     * bypasses `outputEval` and is not subject to the 64 KiB
     * `loadContents` limit.
     */
    Union!(None, Expression) outputEval_;

    mixin genBody;
}

///
class CommandLineBindable : RecordSchemaBase
{
    /**
     * Describes how to turn this object into command line arguments.
     */
    Union!(None, CommandLineBinding) inputBinding_;

    mixin genBody;
}

///
class CommandInputRecordField : RecordSchemaBase
{
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The name of the field
     */
    @id string name_;
    /**
     * The field type
     */
    @typeDSL Union!(CWLType, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string, Union!(CWLType, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string)[]) type_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This must be one or more IRIs of concept nodes
     * that represents file formats which are allowed as input to this
     * parameter, preferably defined within an ontology.  If no ontology is
     * available, file formats may be tested by exact match.
     */
    @link(LinkResolver.id) Union!(None, string, string[], Expression) format_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * If true, the file (or each file in the array) must be a UTF-8
     * text file 64 KiB or smaller, and the implementation must read
     * the entire contents of the file (or file array) and place it
     * in the `contents` field of the File object for use by
     * expressions.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     */
    Union!(None, bool) loadContents_;
    /**
     * Only valid when `type: Directory` or is an array of `items: Directory`.
     * 
     * Specify the desired behavior for loading the `listing` field of
     * a Directory object for use by expressions.
     * 
     * The order of precedence for loadListing is:
     * 
     *   1. `loadListing` on an individual parameter
     *   2. Inherited from `LoadListingRequirement`
     *   3. By default: `no_listing`
     */
    Union!(None, LoadListingEnum) loadListing_;
    /**
     * Describes how to turn this object into command line arguments.
     */
    Union!(None, CommandLineBinding) inputBinding_;

    mixin genBody;
}

///
class CommandInputRecordSchema : RecordSchemaBase
{
    /**
     * Defines the fields of the record.
     */
    @idMap("name", "type") Union!(None, CommandInputRecordField[]) fields_;
    /**
     * Must be `record`
     */
    static immutable type_ = "record";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;
    /**
     * Describes how to turn this object into command line arguments.
     */
    Union!(None, CommandLineBinding) inputBinding_;

    mixin genBody;
}

///
class CommandInputEnumSchema : RecordSchemaBase
{
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;
    /**
     * Defines the set of valid symbols.
     */
    @link(LinkResolver.id) string[] symbols_;
    /**
     * Must be `enum`
     */
    static immutable type_ = "enum";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * Describes how to turn this object into command line arguments.
     */
    Union!(None, CommandLineBinding) inputBinding_;

    mixin genBody;
}

///
class CommandInputArraySchema : RecordSchemaBase
{
    /**
     * Defines the type of the array elements.
     */
    Union!(CWLType, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string, Union!(CWLType, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string)[]) items_;
    /**
     * Must be `array`
     */
    static immutable type_ = "array";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;
    /**
     * Describes how to turn this object into command line arguments.
     */
    Union!(None, CommandLineBinding) inputBinding_;

    mixin genBody;
}

///
class CommandOutputRecordField : RecordSchemaBase
{
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The name of the field
     */
    @id string name_;
    /**
     * The field type
     */
    @typeDSL Union!(CWLType, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string, Union!(CWLType, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string)[]) type_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to the output
     * File object.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Describes how to generate this output object based on the files
     * produced by a CommandLineTool
     */
    Union!(None, CommandOutputBinding) outputBinding_;

    mixin genBody;
}

///
class CommandOutputRecordSchema : RecordSchemaBase
{
    /**
     * Defines the fields of the record.
     */
    @idMap("name", "type") Union!(None, CommandOutputRecordField[]) fields_;
    /**
     * Must be `record`
     */
    static immutable type_ = "record";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;

    mixin genBody;
}

///
class CommandOutputEnumSchema : RecordSchemaBase
{
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;
    /**
     * Defines the set of valid symbols.
     */
    @link(LinkResolver.id) string[] symbols_;
    /**
     * Must be `enum`
     */
    static immutable type_ = "enum";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;

    mixin genBody;
}

///
class CommandOutputArraySchema : RecordSchemaBase
{
    /**
     * Defines the type of the array elements.
     */
    Union!(CWLType, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string, Union!(CWLType, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string)[]) items_;
    /**
     * Must be `array`
     */
    static immutable type_ = "array";
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The identifier for this type
     */
    @id Union!(None, string) name_;

    mixin genBody;
}

/**
 * An input parameter for a CommandLineTool.
 */
class CommandInputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This must be one or more IRIs of concept nodes
     * that represents file formats which are allowed as input to this
     * parameter, preferably defined within an ontology.  If no ontology is
     * available, file formats may be tested by exact match.
     */
    @link(LinkResolver.id) Union!(None, string, string[], Expression) format_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * If true, the file (or each file in the array) must be a UTF-8
     * text file 64 KiB or smaller, and the implementation must read
     * the entire contents of the file (or file array) and place it
     * in the `contents` field of the File object for use by
     * expressions.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     */
    Union!(None, bool) loadContents_;
    /**
     * Only valid when `type: Directory` or is an array of `items: Directory`.
     * 
     * Specify the desired behavior for loading the `listing` field of
     * a Directory object for use by expressions.
     * 
     * The order of precedence for loadListing is:
     * 
     *   1. `loadListing` on an individual parameter
     *   2. Inherited from `LoadListingRequirement`
     *   3. By default: `no_listing`
     */
    Union!(None, LoadListingEnum) loadListing_;
    /**
     * The default value to use for this parameter if the parameter is missing
     * from the input object, or if the value of the parameter in the input
     * object is `null`.  Default values are applied before evaluating expressions
     * (e.g. dependent `valueFrom` fields).
     */
    Union!(None, CWLObjectType) default_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(CWLType, stdin, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string, Union!(CWLType, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string)[]) type_;
    /**
     * Describes how to turn the input parameters of a process into
     * command line arguments.
     */
    Union!(None, CommandLineBinding) inputBinding_;

    mixin genBody;
}

/**
 * An output parameter for a CommandLineTool.
 */
class CommandOutputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to the output
     * File object.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(CWLType, stdout, stderr, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string, Union!(CWLType, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string)[]) type_;
    /**
     * Describes how to generate this output object based on the files produced by a CommandLineTool
     */
    Union!(None, CommandOutputBinding) outputBinding_;

    mixin genBody;
}

/**
 * Only valid as a `type` for a `CommandLineTool` input with no
 * `inputBinding` set. `stdin` must not be specified at the `CommandLineTool`
 * level.
 * 
 * The following
 * ```
 * inputs:
 *    an_input_name:
 *    type: stdin
 * ```
 * is equivalent to
 * ```
 * inputs:
 *   an_input_name:
 *     type: File
 *     streamable: true
 * 
 * stdin: $(inputs.an_input_name.path)
 * ```
 */
class stdin : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "stdin", ///
    }

    Symbol value;

    mixin genBody;
}

/**
 * Only valid as a `type` for a `CommandLineTool` output with no
 * `outputBinding` set.
 * 
 * The following
 * ```
 * outputs:
 *   an_output_name:
 *     type: stdout
 * 
 * stdout: a_stdout_file
 * ```
 * is equivalent to
 * ```
 * outputs:
 *   an_output_name:
 *     type: File
 *     streamable: true
 *     outputBinding:
 *       glob: a_stdout_file
 * 
 * stdout: a_stdout_file
 * ```
 * 
 * If there is no `stdout` name provided, a random filename will be created.
 * For example, the following
 * ```
 * outputs:
 *   an_output_name:
 *     type: stdout
 * ```
 * is equivalent to
 * ```
 * outputs:
 *   an_output_name:
 *     type: File
 *     streamable: true
 *     outputBinding:
 *       glob: random_stdout_filenameABCDEFG
 * 
 * stdout: random_stdout_filenameABCDEFG
 * ```
 * 
 * If the `CommandLineTool` contains logically chained commands
 * (e.g. `echo a && echo b`) `stdout` must include the output of
 * every command.
 */
class stdout : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "stdout", ///
    }

    Symbol value;

    mixin genBody;
}

/**
 * Only valid as a `type` for a `CommandLineTool` output with no
 * `outputBinding` set.
 * 
 * The following
 * ```
 * outputs:
 *   an_output_name:
 *   type: stderr
 * 
 * stderr: a_stderr_file
 * ```
 * is equivalent to
 * ```
 * outputs:
 *   an_output_name:
 *     type: File
 *     streamable: true
 *     outputBinding:
 *       glob: a_stderr_file
 * 
 * stderr: a_stderr_file
 * ```
 * 
 * If there is no `stderr` name provided, a random filename will be created.
 * For example, the following
 * ```
 * outputs:
 *   an_output_name:
 *     type: stderr
 * ```
 * is equivalent to
 * ```
 * outputs:
 *   an_output_name:
 *     type: File
 *     streamable: true
 *     outputBinding:
 *       glob: random_stderr_filenameABCDEFG
 * 
 * stderr: random_stderr_filenameABCDEFG
 * ```
 */
class stderr : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "stderr", ///
    }

    Symbol value;

    mixin genBody;
}

/**
 * This defines the schema of the CWL Command Line Tool Description document.
 */
@documentRoot class CommandLineTool : RecordSchemaBase
{
    /**
     * The unique identifier for this object.
     * 
     * Only useful for `$graph` at `Process` level. Should not be exposed
     * to users in graphical or terminal user interfaces.
     */
    @id Union!(None, string) id_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * Defines the input parameters of the process.  The process is ready to
     * run when all required input parameters are associated with concrete
     * values.  Input parameters include a schema for each parameter which is
     * used to validate the input object.  It may also be used to build a user
     * interface for constructing the input object.
     * 
     * When accepting an input object, all input parameters must have a value.
     * If an input parameter is missing from the input object, it must be
     * assigned a value of `null` (or the value of `default` for that
     * parameter, if provided) for the purposes of validation and evaluation
     * of expressions.
     */
    @idMap("id", "type") CommandInputParameter[] inputs_;
    /**
     * Defines the parameters representing the output of the process.  May be
     * used to generate and/or validate the output object.
     */
    @idMap("id", "type") CommandOutputParameter[] outputs_;
    /**
     * Declares requirements that apply to either the runtime environment or the
     * workflow engine that must be met in order to execute this process.  If
     * an implementation cannot satisfy all requirements, or a requirement is
     * listed which is not recognized by the implementation, it is a fatal
     * error and the implementation must not attempt to run the process,
     * unless overridden at user option.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this process.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) hints_;
    /**
     * CWL document version. Always required at the document root. Not
     * required for a Process embedded inside another Process.
     */
    Union!(None, CWLVersion) cwlVersion_;
    /**
     * An identifier for the type of computational operation, of this Process.
     * Especially useful for [`Operation`](Workflow.html#Operation), but can also be used for
     * [`CommandLineTool`](CommandLineTool.html#CommandLineTool),
     * [`Workflow`](Workflow.html#Workflow), or [ExpressionTool](Workflow.html#ExpressionTool).
     * 
     * If provided, then this must be an IRI of a concept node that
     * represents the type of operation, preferably defined within an ontology.
     * 
     * For example, in the domain of bioinformatics, one can use an IRI from
     * the EDAM Ontology's [Operation concept nodes](http://edamontology.org/operation_0004),
     * like [Alignment](http://edamontology.org/operation_2928),
     * or [Clustering](http://edamontology.org/operation_3432); or a more
     * specific Operation concept like
     * [Split read mapping](http://edamontology.org/operation_3199).
     */
    @link(LinkResolver.id) Union!(None, string[]) intent_;
    ///
    static immutable class_ = "CommandLineTool";
    /**
     * Specifies the program to execute.  If an array, the first element of
     * the array is the command to execute, and subsequent elements are
     * mandatory command line arguments.  The elements in `baseCommand` must
     * appear before any command line bindings from `inputBinding` or
     * `arguments`.
     * 
     * If `baseCommand` is not provided or is an empty array, the first
     * element of the command line produced after processing `inputBinding` or
     * `arguments` must be used as the program to execute.
     * 
     * If the program includes a path separator character it must
     * be an absolute path, otherwise it is an error.  If the program does not
     * include a path separator, search the `$PATH` variable in the runtime
     * environment of the workflow runner find the absolute path of the
     * executable.
     */
    Union!(None, string, string[]) baseCommand_;
    /**
     * Command line bindings which are not directly associated with input
     * parameters. If the value is a string, it is used as a string literal
     * argument. If it is an Expression, the result of the evaluation is used
     * as an argument.
     */
    Union!(None, Union!(string, Expression, CommandLineBinding)[]) arguments_;
    /**
     * A path to a file whose contents must be piped into the command's
     * standard input stream.
     */
    Union!(None, string, Expression) stdin_;
    /**
     * Capture the command's standard error stream to a file written to
     * the designated output directory.
     * 
     * If `stderr` is a string, it specifies the file name to use.
     * 
     * If `stderr` is an expression, the expression is evaluated and must
     * return a string with the file name to use to capture stderr.  If the
     * return value is not a string, or the resulting path contains illegal
     * characters (such as the path separator `/`) it is an error.
     */
    Union!(None, string, Expression) stderr_;
    /**
     * Capture the command's standard output stream to a file written to
     * the designated output directory.
     * 
     * If the `CommandLineTool` contains logically chained commands
     * (e.g. `echo a && echo b`) `stdout` must include the output of
     * every command.
     * 
     * If `stdout` is a string, it specifies the file name to use.
     * 
     * If `stdout` is an expression, the expression is evaluated and must
     * return a string with the file name to use to capture stdout.  If the
     * return value is not a string, or the resulting path contains illegal
     * characters (such as the path separator `/`) it is an error.
     */
    Union!(None, string, Expression) stdout_;
    /**
     * Exit codes that indicate the process completed successfully.
     * 
     * If not specified, only exit code 0 is considered success.
     */
    Union!(None, int[]) successCodes_;
    /**
     * Exit codes that indicate the process failed due to a possibly
     * temporary condition, where executing the process with the same
     * runtime environment and inputs may produce different results.
     * 
     * If not specified, no exit codes are considered temporary failure.
     */
    Union!(None, int[]) temporaryFailCodes_;
    /**
     * Exit codes that indicate the process failed due to a permanent logic error, where executing the process with the same runtime environment and same inputs is expected to always fail.
     * If not specified, all exit codes except 0 are considered permanent failure.
     */
    Union!(None, int[]) permanentFailCodes_;

    mixin genBody;
}

/**
 * Indicates that a workflow component should be run in a
 * [Docker](https://docker.com) or Docker-compatible (such as
 * [Singularity](https://www.sylabs.io/) and [udocker](https://github.com/indigo-dc/udocker)) container environment and
 * specifies how to fetch or build the image.
 * 
 * If a CommandLineTool lists `DockerRequirement` under
 * `hints` (or `requirements`), it may (or must) be run in the specified Docker
 * container.
 * 
 * The platform must first acquire or install the correct Docker image as
 * specified by `dockerPull`, `dockerImport`, `dockerLoad` or `dockerFile`.
 * 
 * The platform must execute the tool in the container using `docker run` with
 * the appropriate Docker image and tool command line.
 * 
 * The workflow platform may provide input files and the designated output
 * directory through the use of volume bind mounts.  The platform should rewrite
 * file paths in the input object to correspond to the Docker bind mounted
 * locations. That is, the platform should rewrite values in the parameter context
 * such as `runtime.outdir`, `runtime.tmpdir` and others to be valid paths
 * within the container. The platform must ensure that `runtime.outdir` and
 * `runtime.tmpdir` are distinct directories.
 * 
 * When running a tool contained in Docker, the workflow platform must not
 * assume anything about the contents of the Docker container, such as the
 * presence or absence of specific software, except to assume that the
 * generated command line represents a valid command within the runtime
 * environment of the container.
 * 
 * A container image may specify an
 * [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint)
 * and/or
 * [CMD](https://docs.docker.com/engine/reference/builder/#cmd).
 * Command line arguments will be appended after all elements of
 * ENTRYPOINT, and will override all elements specified using CMD (in
 * other words, CMD is only used when the CommandLineTool definition
 * produces an empty command line).
 * 
 * Use of implicit ENTRYPOINT or CMD are discouraged due to reproducibility
 * concerns of the implicit hidden execution point (For further discussion, see
 * [https://doi.org/10.12688/f1000research.15140.1](https://doi.org/10.12688/f1000research.15140.1)). Portable
 * CommandLineTool wrappers in which use of a container is optional must not rely on ENTRYPOINT or CMD.
 * CommandLineTools which do rely on ENTRYPOINT or CMD must list `DockerRequirement` in the
 * `requirements` section.
 * 
 * ## Interaction with other requirements
 * 
 * If [EnvVarRequirement](#EnvVarRequirement) is specified alongside a
 * DockerRequirement, the environment variables must be provided to Docker
 * using `--env` or `--env-file` and interact with the container's preexisting
 * environment as defined by Docker.
 */
class DockerRequirement : RecordSchemaBase
{
    /**
     * Always 'DockerRequirement'
     */
    static immutable class_ = "DockerRequirement";
    /**
     * Specify a Docker image to retrieve using `docker pull`. Can contain the
     * immutable digest to ensure an exact container is used:
     * `dockerPull: ubuntu@sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2`
     */
    Union!(None, string) dockerPull_;
    /**
     * Specify an HTTP URL from which to download a Docker image using `docker load`.
     */
    Union!(None, string) dockerLoad_;
    /**
     * Supply the contents of a Dockerfile which will be built using `docker build`.
     */
    Union!(None, string) dockerFile_;
    /**
     * Provide HTTP URL to download and gunzip a Docker images using `docker import.
     */
    Union!(None, string) dockerImport_;
    /**
     * The image id that will be used for `docker run`.  May be a
     * human-readable image name or the image identifier hash.  May be skipped
     * if `dockerPull` is specified, in which case the `dockerPull` image id
     * must be used.
     */
    Union!(None, string) dockerImageId_;
    /**
     * Set the designated output directory to a specific location inside the
     * Docker container.
     */
    Union!(None, string) dockerOutputDirectory_;

    mixin genBody;
}

/**
 * A list of software packages that should be configured in the environment of
 * the defined process.
 */
class SoftwareRequirement : RecordSchemaBase
{
    /**
     * Always 'SoftwareRequirement'
     */
    static immutable class_ = "SoftwareRequirement";
    /**
     * The list of software to be configured.
     */
    @idMap("package", "specs") SoftwarePackage[] packages_;

    mixin genBody;
}

///
class SoftwarePackage : RecordSchemaBase
{
    /**
     * The name of the software to be made available. If the name is
     * common, inconsistent, or otherwise ambiguous it should be combined with
     * one or more identifiers in the `specs` field.
     */
    string package_;
    /**
     * The (optional) versions of the software that are known to be
     * compatible.
     */
    Union!(None, string[]) version_;
    /**
     * One or more [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier)s
     * identifying resources for installing or enabling the software named in
     * the `package` field. Implementations may provide resolvers which map
     * these software identifier IRIs to some configuration action; or they can
     * use only the name from the `package` field on a best effort basis.
     * 
     * For example, the IRI https://packages.debian.org/bowtie could
     * be resolved with `apt-get install bowtie`. The IRI
     * https://anaconda.org/bioconda/bowtie could be resolved with `conda
     * install -c bioconda bowtie`.
     * 
     * IRIs can also be system independent and used to map to a specific
     * software installation or selection mechanism.
     * Using [RRID](https://www.identifiers.org/rrid/) as an example:
     * https://identifiers.org/rrid/RRID:SCR_005476
     * could be fulfilled using the above-mentioned Debian or bioconda
     * package, a local installation managed by [Environment Modules](https://modules.sourceforge.net/),
     * or any other mechanism the platform chooses. IRIs can also be from
     * identifier sources that are discipline specific yet still system
     * independent. As an example, the equivalent [ELIXIR Tools and Data
     * Service Registry](https://bio.tools) IRI to the previous RRID example is
     * https://bio.tools/tool/bowtie2/version/2.2.8.
     * If supported by a given registry, implementations are encouraged to
     * query these system independent software identifier IRIs directly for
     * links to packaging systems.
     * 
     * A site specific IRI can be listed as well. For example, an academic
     * computing cluster using Environment Modules could list the IRI
     * `https://hpc.example.edu/modules/bowtie-tbb/1.22` to indicate that
     * `module load bowtie-tbb/1.1.2` should be executed to make available
     * `bowtie` version 1.1.2 compiled with the TBB library prior to running
     * the accompanying Workflow or CommandLineTool. Note that the example IRI
     * is specific to a particular institution and computing environment as
     * the Environment Modules system does not have a common namespace or
     * standardized naming convention.
     * 
     * This last example is the least portable and should only be used if
     * mechanisms based off of the `package` field or more generic IRIs are
     * unavailable or unsuitable. While harmless to other sites, site specific
     * software IRIs should be left out of shared CWL descriptions to avoid
     * clutter.
     */
    @link() Union!(None, string[]) specs_;

    mixin genBody;
}

/**
 * Define a file or subdirectory that must be staged to a particular
 * place prior to executing the command line tool.  May be the result
 * of executing an expression, such as building a configuration file
 * from a template.
 * 
 * Usually files are staged within the [designated output directory](#Runtime_environment).
 * However, under certain circumstances, files may be staged at
 * arbitrary locations, see discussion for `entryname`.
 */
class Dirent : RecordSchemaBase
{
    /**
     * The "target" name of the file or subdirectory.  If `entry` is
     * a File or Directory, the `entryname` field overrides the value
     * of `basename` of the File or Directory object.
     * 
     * * Required when `entry` evaluates to file contents only
     * * Optional when `entry` evaluates to a File or Directory object with a `basename`
     * * Invalid when `entry` evaluates to an array of File or Directory objects.
     * 
     * If `entryname` is a relative path, it specifies a name within
     * the designated output directory.  A relative path starting
     * with `../` or that resolves to location above the designated output directory is an error.
     * 
     * If `entryname` is an absolute path (starts with a slash `/`)
     * it is an error unless the following conditions are met:
     * 
     *   * `DockerRequirement` is present in `requirements`
     *   * The program is will run inside a software container
     *   where, from the perspective of the program, the root
     *   filesystem is not shared with any other user or
     *   running program.
     * 
     * In this case, and the above conditions are met, then
     * `entryname` may specify the absolute path within the container
     * where the file or directory must be placed.
     */
    Union!(None, string, Expression) entryname_;
    /**
     * If the value is a string literal or an expression which evaluates to a
     * string, a new text file must be created with the string as the file contents.
     * 
     * If the value is an expression that evaluates to a `File` or
     * `Directory` object, or an array of `File` or `Directory`
     * objects, this indicates the referenced file or directory
     * should be added to the designated output directory prior to
     * executing the tool.
     * 
     * If the value is an expression that evaluates to `null`,
     * nothing is added to the designated output directory, the entry
     * has no effect.
     * 
     * If the value is an expression that evaluates to some other
     * array, number, or object not consisting of `File` or
     * `Directory` objects, a new file must be created with the value
     * serialized to JSON text as the file contents.  The JSON
     * serialization behavior should match the behavior of string
     * interpolation of [Parameter
     * references](#Parameter_references).
     */
    Union!(string, Expression) entry_;
    /**
     * If true, the File or Directory (or array of Files or
     * Directories) declared in `entry` must be writable by the tool.
     * 
     * Changes to the file or directory must be isolated and not
     * visible by any other CommandLineTool process.  This may be
     * implemented by making a copy of the original file or
     * directory.
     * 
     * Disruptive changes to the referenced file or directory must not
     * be allowed unless `InplaceUpdateRequirement.inplaceUpdate` is true.
     * 
     * Default false (files and directories read-only by default).
     * 
     * A directory marked as `writable: true` implies that all files and
     * subdirectories are recursively writable as well.
     * 
     * If `writable` is false, the file may be made available using a
     * bind mount or file system link to avoid unnecessary copying of
     * the input file.  Command line tools may receive an error on
     * attempting to rename or delete files or directories that are
     * not explicitly marked as writable.
     */
    @defaultValue(q"<false>") bool writable_;

    mixin genBody;
}

/**
 * Define a list of files and subdirectories that must be staged by the workflow platform prior to executing the command line tool.
 * Normally files are staged within the designated output directory. However, when running inside containers, files may be staged at arbitrary locations, see discussion for [`Dirent.entryname`](#Dirent). Together with `DockerRequirement.dockerOutputDirectory` it is possible to control the locations of both input and output files when running in containers.
 */
class InitialWorkDirRequirement : RecordSchemaBase
{
    /**
     * InitialWorkDirRequirement
     */
    static immutable class_ = "InitialWorkDirRequirement";
    /**
     * The list of files or subdirectories that must be staged prior
     * to executing the command line tool.
     * 
     * Return type of each expression must validate as `["null",
     * File, Directory, Dirent, {type: array, items: [File,
     * Directory]}]`.
     * 
     * Each `File` or `Directory` that is returned by an Expression
     * must be added to the designated output directory prior to
     * executing the tool.
     * 
     * Each `Dirent` record that is listed or returned by an
     * expression specifies a file to be created or staged in the
     * designated output directory prior to executing the tool.
     * 
     * Expressions may return null, in which case they have no effect.
     * 
     * Files or Directories which are listed in the input parameters
     * and appear in the `InitialWorkDirRequirement` listing must
     * have their `path` set to their staged location.  If the same
     * File or Directory appears more than once in the
     * `InitialWorkDirRequirement` listing, the implementation must
     * choose exactly one value for `path`; how this value is chosen
     * is undefined.
     */
    Union!(Expression, Union!(None, Dirent, Expression, File, Directory, Union!(File, Directory)[])[]) listing_;

    mixin genBody;
}

/**
 * Define a list of environment variables which will be set in the
 * execution environment of the tool.  See `EnvironmentDef` for details.
 */
class EnvVarRequirement : RecordSchemaBase
{
    /**
     * Always 'EnvVarRequirement'
     */
    static immutable class_ = "EnvVarRequirement";
    /**
     * The list of environment variables.
     */
    @idMap("envName", "envValue") EnvironmentDef[] envDef_;

    mixin genBody;
}

/**
 * Modify the behavior of CommandLineTool to generate a single string
 * containing a shell command line.  Each item in the `arguments` list must
 * be joined into a string separated by single spaces and quoted to prevent
 * interpretation by the shell, unless `CommandLineBinding` for that argument
 * contains `shellQuote: false`.  If `shellQuote: false` is specified, the
 * argument is joined into the command string without quoting, which allows
 * the use of shell metacharacters such as `|` for pipes.
 */
class ShellCommandRequirement : RecordSchemaBase
{
    /**
     * Always 'ShellCommandRequirement'
     */
    static immutable class_ = "ShellCommandRequirement";

    mixin genBody;
}

/**
 * Specify basic hardware resource requirements.
 * 
 * "min" is the minimum amount of a resource that must be reserved to
 * schedule a job. If "min" cannot be satisfied, the job should not
 * be run.
 * 
 * "max" is the maximum amount of a resource that the job shall be
 * allocated. If a node has sufficient resources, multiple jobs may
 * be scheduled on a single node provided each job's "max" resource
 * requirements are met. If a job attempts to exceed its resource
 * allocation, an implementation may deny additional resources, which
 * may result in job failure.
 * 
 * If both "min" and "max" are specified, an implementation may
 * choose to allocate any amount between "min" and "max", with the
 * actual allocation provided in the `runtime` object.
 * 
 * If "min" is specified but "max" is not, then "max" == "min"
 * If "max" is specified by "min" is not, then "min" == "max".
 * 
 * It is an error if max < min.
 * 
 * It is an error if the value of any of these fields is negative.
 * 
 * If neither "min" nor "max" is specified for a resource, use the default values below.
 */
class ResourceRequirement : RecordSchemaBase
{
    /**
     * Always 'ResourceRequirement'
     */
    static immutable class_ = "ResourceRequirement";
    /**
     * Minimum reserved number of CPU cores (default is 1).
     * 
     * May be a fractional value to indicate to a scheduling
     * algorithm that one core can be allocated to multiple
     * jobs. For example, a value of 0.25 indicates that up to 4
     * jobs may run in parallel on 1 core.  A value of 1.25 means
     * that up to 3 jobs can run on a 4 core system (4/1.25 ≈ 3).
     * 
     * Processes can only share a core allocation if the sum of each
     * of their `ramMax`, `tmpdirMax`, and `outdirMax` requests also
     * do not exceed the capacity of the node.
     * 
     * Processes sharing a core must have the same level of isolation
     * (typically a container or VM) that they would normally have.
     * 
     * The reported number of CPU cores reserved for the process,
     * which is available to expressions on the CommandLineTool as
     * `runtime.cores`, must be a non-zero integer, and may be
     * calculated by rounding up the cores request to the next whole
     * number.
     * 
     * Scheduling systems may allocate fractional CPU resources by
     * setting quotas or scheduling weights.  Scheduling systems that
     * do not support fractional CPUs may round up the request to the
     * next whole number.
     */
    Union!(None, int, long, float, Expression) coresMin_;
    /**
     * Maximum reserved number of CPU cores.
     * 
     * See `coresMin` for discussion about fractional CPU requests.
     */
    Union!(None, int, long, float, Expression) coresMax_;
    /**
     * Minimum reserved RAM in mebibytes (2**20) (default is 256)
     * 
     * May be a fractional value.  If so, the actual RAM request must
     * be rounded up to the next whole number.  The reported amount of
     * RAM reserved for the process, which is available to
     * expressions on the CommandLineTool as `runtime.ram`, must be a
     * non-zero integer.
     */
    Union!(None, int, long, float, Expression) ramMin_;
    /**
     * Maximum reserved RAM in mebibytes (2**20)
     * 
     * See `ramMin` for discussion about fractional RAM requests.
     */
    Union!(None, int, long, float, Expression) ramMax_;
    /**
     * Minimum reserved filesystem based storage for the designated temporary directory, in mebibytes (2**20) (default is 1024)
     * 
     * May be a fractional value.  If so, the actual storage request
     * must be rounded up to the next whole number.  The reported
     * amount of storage reserved for the process, which is available
     * to expressions on the CommandLineTool as `runtime.tmpdirSize`,
     * must be a non-zero integer.
     */
    Union!(None, int, long, float, Expression) tmpdirMin_;
    /**
     * Maximum reserved filesystem based storage for the designated temporary directory, in mebibytes (2**20)
     * 
     * See `tmpdirMin` for discussion about fractional storage requests.
     */
    Union!(None, int, long, float, Expression) tmpdirMax_;
    /**
     * Minimum reserved filesystem based storage for the designated output directory, in mebibytes (2**20) (default is 1024)
     * 
     * May be a fractional value.  If so, the actual storage request
     * must be rounded up to the next whole number.  The reported
     * amount of storage reserved for the process, which is available
     * to expressions on the CommandLineTool as `runtime.outdirSize`,
     * must be a non-zero integer.
     */
    Union!(None, int, long, float, Expression) outdirMin_;
    /**
     * Maximum reserved filesystem based storage for the designated output directory, in mebibytes (2**20)
     * 
     * See `outdirMin` for discussion about fractional storage requests.
     */
    Union!(None, int, long, float, Expression) outdirMax_;

    mixin genBody;
}

/**
 * For implementations that support reusing output from past work (on
 * the assumption that same code and same input produce same
 * results), control whether to enable or disable the reuse behavior
 * for a particular tool or step (to accommodate situations where that
 * assumption is incorrect).  A reused step is not executed but
 * instead returns the same output as the original execution.
 * 
 * If `WorkReuse` is not specified, correct tools should assume it
 * is enabled by default.
 */
class WorkReuse : RecordSchemaBase
{
    /**
     * Always 'WorkReuse'
     */
    static immutable class_ = "WorkReuse";
    ///
    @defaultValue(q"<true>") Union!(bool, Expression) enableReuse_;

    mixin genBody;
}

/**
 * Indicate whether a process requires outgoing IPv4/IPv6 network
 * access.  Choice of IPv4 or IPv6 is implementation and site
 * specific, correct tools must support both.
 * 
 * If `networkAccess` is false or not specified, tools must not
 * assume network access, except for localhost (the loopback device).
 * 
 * If `networkAccess` is true, the tool must be able to make outgoing
 * connections to network resources.  Resources may be on a private
 * subnet or the public Internet.  However, implementations and sites
 * may apply their own security policies to restrict what is
 * accessible by the tool.
 * 
 * Enabling network access does not imply a publicly routable IP
 * address or the ability to accept inbound connections.
 */
class NetworkAccess : RecordSchemaBase
{
    /**
     * Always 'NetworkAccess'
     */
    static immutable class_ = "NetworkAccess";
    ///
    Union!(bool, Expression) networkAccess_;

    mixin genBody;
}

/**
 * 
 * If `inplaceUpdate` is true, then an implementation supporting this
 * feature may permit tools to directly update files with `writable:
 * true` in InitialWorkDirRequirement.  That is, as an optimization,
 * files may be destructively modified in place as opposed to copied
 * and updated.
 * 
 * An implementation must ensure that only one workflow step may
 * access a writable file at a time.  It is an error if a file which
 * is writable by one workflow step file is accessed (for reading or
 * writing) by any other workflow step running independently.
 * However, a file which has been updated in a previous completed
 * step may be used as input to multiple steps, provided it is
 * read-only in every step.
 * 
 * Workflow steps which modify a file must produce the modified file
 * as output.  Downstream steps which further process the file must
 * use the output of previous steps, and not refer to a common input
 * (this is necessary for both ordering and correctness).
 * 
 * Workflow authors should provide this in the `hints` section.  The
 * intent of this feature is that workflows produce the same results
 * whether or not InplaceUpdateRequirement is supported by the
 * implementation, and this feature is primarily available as an
 * optimization for particular environments.
 * 
 * Users and implementers should be aware that workflows that
 * destructively modify inputs may not be repeatable or reproducible.
 * In particular, enabling this feature implies that WorkReuse should
 * not be enabled.
 */
class InplaceUpdateRequirement : RecordSchemaBase
{
    /**
     * Always 'InplaceUpdateRequirement'
     */
    static immutable class_ = "InplaceUpdateRequirement";
    ///
    bool inplaceUpdate_;

    mixin genBody;
}

/**
 * Set an upper limit on the execution time of a CommandLineTool.
 * A CommandLineTool whose execution duration exceeds the time
 * limit may be preemptively terminated and considered failed.
 * May also be used by batch systems to make scheduling decisions.
 * The execution duration excludes external operations, such as
 * staging of files, pulling a docker image etc, and only counts
 * wall-time for the execution of the command line itself.
 */
class ToolTimeLimit : RecordSchemaBase
{
    /**
     * Always 'ToolTimeLimit'
     */
    static immutable class_ = "ToolTimeLimit";
    /**
     * The time limit, in seconds.  A time limit of zero means no
     * time limit.  Negative time limits are an error.
     */
    Union!(int, long, Expression) timelimit_;

    mixin genBody;
}

///
class ExpressionToolOutputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to the output
     * File object.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     * Note that this field just acts as a hint, as the outputs of an
     * ExpressionTool process are always considered valid.
     */
    @typeDSL Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string, Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string)[]) type_;

    mixin genBody;
}

///
class WorkflowInputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This must be one or more IRIs of concept nodes
     * that represents file formats which are allowed as input to this
     * parameter, preferably defined within an ontology.  If no ontology is
     * available, file formats may be tested by exact match.
     */
    @link(LinkResolver.id) Union!(None, string, string[], Expression) format_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * If true, the file (or each file in the array) must be a UTF-8
     * text file 64 KiB or smaller, and the implementation must read
     * the entire contents of the file (or file array) and place it
     * in the `contents` field of the File object for use by
     * expressions.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     */
    Union!(None, bool) loadContents_;
    /**
     * Only valid when `type: Directory` or is an array of `items: Directory`.
     * 
     * Specify the desired behavior for loading the `listing` field of
     * a Directory object for use by expressions.
     * 
     * The order of precedence for loadListing is:
     * 
     *   1. `loadListing` on an individual parameter
     *   2. Inherited from `LoadListingRequirement`
     *   3. By default: `no_listing`
     */
    Union!(None, LoadListingEnum) loadListing_;
    /**
     * The default value to use for this parameter if the parameter is missing
     * from the input object, or if the value of the parameter in the input
     * object is `null`.  Default values are applied before evaluating expressions
     * (e.g. dependent `valueFrom` fields).
     */
    Union!(None, CWLObjectType) default_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string, Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string)[]) type_;
    /**
     * Deprecated.  Preserved for v1.0 backwards compatibility.  Will be removed in
     * CWL v2.0.  Use `WorkflowInputParameter.loadContents` instead.
     */
    Union!(None, InputBinding) inputBinding_;

    mixin genBody;
}

/**
 * An ExpressionTool is a type of Process object that can be run by itself
 * or as a Workflow step. It executes a pure Javascript expression that has
 * access to the same input parameters as a workflow. It is meant to be used
 * sparingly as a way to isolate complex Javascript expressions that need to
 * operate on input data and produce some result; perhaps just a
 * rearrangement of the inputs. No Docker software container is required
 * or allowed.
 */
@documentRoot class ExpressionTool : RecordSchemaBase
{
    /**
     * The unique identifier for this object.
     * 
     * Only useful for `$graph` at `Process` level. Should not be exposed
     * to users in graphical or terminal user interfaces.
     */
    @id Union!(None, string) id_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * Defines the input parameters of the process.  The process is ready to
     * run when all required input parameters are associated with concrete
     * values.  Input parameters include a schema for each parameter which is
     * used to validate the input object.  It may also be used to build a user
     * interface for constructing the input object.
     * 
     * When accepting an input object, all input parameters must have a value.
     * If an input parameter is missing from the input object, it must be
     * assigned a value of `null` (or the value of `default` for that
     * parameter, if provided) for the purposes of validation and evaluation
     * of expressions.
     */
    @idMap("id", "type") WorkflowInputParameter[] inputs_;
    /**
     * Defines the parameters representing the output of the process.  May be
     * used to generate and/or validate the output object.
     */
    @idMap("id", "type") ExpressionToolOutputParameter[] outputs_;
    /**
     * Declares requirements that apply to either the runtime environment or the
     * workflow engine that must be met in order to execute this process.  If
     * an implementation cannot satisfy all requirements, or a requirement is
     * listed which is not recognized by the implementation, it is a fatal
     * error and the implementation must not attempt to run the process,
     * unless overridden at user option.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this process.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) hints_;
    /**
     * CWL document version. Always required at the document root. Not
     * required for a Process embedded inside another Process.
     */
    Union!(None, CWLVersion) cwlVersion_;
    /**
     * An identifier for the type of computational operation, of this Process.
     * Especially useful for [`Operation`](Workflow.html#Operation), but can also be used for
     * [`CommandLineTool`](CommandLineTool.html#CommandLineTool),
     * [`Workflow`](Workflow.html#Workflow), or [ExpressionTool](Workflow.html#ExpressionTool).
     * 
     * If provided, then this must be an IRI of a concept node that
     * represents the type of operation, preferably defined within an ontology.
     * 
     * For example, in the domain of bioinformatics, one can use an IRI from
     * the EDAM Ontology's [Operation concept nodes](http://edamontology.org/operation_0004),
     * like [Alignment](http://edamontology.org/operation_2928),
     * or [Clustering](http://edamontology.org/operation_3432); or a more
     * specific Operation concept like
     * [Split read mapping](http://edamontology.org/operation_3199).
     */
    @link(LinkResolver.id) Union!(None, string[]) intent_;
    ///
    static immutable class_ = "ExpressionTool";
    /**
     * The expression to execute.  The expression must return a plain
     * Javascript object which matches the output parameters of the
     * ExpressionTool.
     */
    Expression expression_;

    mixin genBody;
}

/**
 * The input link merge method, described in [WorkflowStepInput](#WorkflowStepInput).
 */
class LinkMergeMethod : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "merge_nested", ///
        s1 = "merge_flattened", ///
    }

    Symbol value;

    mixin genBody;
}

/**
 * Picking non-null values among inbound data links, described in [WorkflowStepInput](#WorkflowStepInput).
 */
class PickValueMethod : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "first_non_null", ///
        s1 = "the_only_non_null", ///
        s2 = "all_non_null", ///
    }

    Symbol value;

    mixin genBody;
}

/**
 * Describe an output parameter of a workflow.  The parameter must be
 * connected to one or more parameters defined in the workflow that
 * will provide the value of the output parameter. It is legal to
 * connect a WorkflowInputParameter to a WorkflowOutputParameter.
 * 
 * See [WorkflowStepInput](#WorkflowStepInput) for discussion of
 * `linkMerge` and `pickValue`.
 */
class WorkflowOutputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to the output
     * File object.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Specifies one or more names of an output from a workflow step (in the form
     * `step_name/output_name` with a `/` separator`), or a workflow input name,
     * that supply their value(s) to the output parameter.
     * the output parameter.  It is valid to reference workflow level inputs
     * here.
     */
    @link() Union!(None, string, string[]) outputSource_;
    /**
     * The method to use to merge multiple sources into a single array.
     * If not specified, the default method is "merge_nested".
     */
    @defaultValue(q"<"merge_nested">") LinkMergeMethod linkMerge_;
    /**
     * The method to use to choose non-null elements among multiple sources.
     */
    Union!(None, PickValueMethod) pickValue_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string, Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string)[]) type_;

    mixin genBody;
}

/**
 * The input of a workflow step connects an upstream parameter (from the
 * workflow inputs, or the outputs of other workflows steps) with the input
 * parameters of the process specified by the `run` field. Only input parameters
 * declared by the target process will be passed through at runtime to the process
 * though additional parameters may be specified (for use within `valueFrom`
 * expressions for instance) - unconnected or unused parameters do not represent an
 * error condition.
 * 
 * # Input object
 * 
 * A WorkflowStepInput object must contain an `id` field in the form
 * `#fieldname` or `#prefix/fieldname`.  When the `id` field contains a slash
 * `/` the field name consists of the characters following the final slash
 * (the prefix portion may contain one or more slashes to indicate scope).
 * This defines a field of the workflow step input object with the value of
 * the `source` parameter(s).
 * 
 * # Merging multiple inbound data links
 * 
 * To merge multiple inbound data links,
 * [MultipleInputFeatureRequirement](#MultipleInputFeatureRequirement) must be specified
 * in the workflow or workflow step requirements.
 * 
 * If the sink parameter is an array, or named in a [workflow
 * scatter](#WorkflowStep) operation, there may be multiple inbound
 * data links listed in the `source` field.  The values from the
 * input links are merged depending on the method specified in the
 * `linkMerge` field.  If both `linkMerge` and `pickValue` are null
 * or not specified, and there is more than one element in the
 * `source` array, the default method is "merge_nested".
 * 
 * If both `linkMerge` and `pickValue` are null or not specified, and
 * there is only a single element in the `source`, then the input
 * parameter takes the scalar value from the single input link (it is
 * *not* wrapped in a single-list).
 * 
 * * **merge_nested**
 * 
 *   The input must be an array consisting of exactly one entry for each
 *   input link.  If "merge_nested" is specified with a single link, the value
 *   from the link must be wrapped in a single-item list.
 * 
 * * **merge_flattened**
 * 
 *   1. The source and sink parameters must be compatible types, or the source
 *      type must be compatible with single element from the "items" type of
 *      the destination array parameter.
 *   2. Source parameters which are arrays are concatenated.
 *      Source parameters which are single element types are appended as
 *      single elements.
 * 
 * # Picking non-null values among inbound data links
 * 
 * If present, `pickValue` specifies how to pick non-null values among inbound data links.
 * 
 * `pickValue` is evaluated
 *   1. Once all source values from upstream step or parameters are available.
 *   2. After `linkMerge`.
 *   3. Before `scatter` or `valueFrom`.
 * 
 * This is specifically intended to be useful in combination with
 * [conditional execution](#WorkflowStep), where several upstream
 * steps may be connected to a single input (`source` is a list), and
 * skipped steps produce null values.
 * 
 * Static type checkers should check for type consistency after inferring what the type
 * will be after `pickValue` is applied, just as they do currently for `linkMerge`.
 * 
 * * **first_non_null**
 * 
 *   For the first level of a list input, pick the first non-null element.  The result is a scalar.
 *   It is an error if there is no non-null element.  Examples:
 *   * `[null, x, null, y] -> x`
 *   * `[null, [null], null, y] -> [null]`
 *   * `[null, null, null] -> Runtime Error`
 * 
 *   *Intended use case*: If-else pattern where the
 *   value comes either from a conditional step or from a default or
 *   fallback value. The conditional step(s) should be placed first in
 *   the list.
 * 
 * * **the_only_non_null**
 * 
 *   For the first level of a list input, pick the single non-null element.  The result is a scalar.
 *   It is an error if there is more than one non-null element.  Examples:
 * 
 *   * `[null, x, null] -> x`
 *   * `[null, x, null, y] -> Runtime Error`
 *   * `[null, [null], null] -> [null]`
 *   * `[null, null, null] -> Runtime Error`
 * 
 *   *Intended use case*: Switch type patterns where developer considers
 *   more than one active code path as a workflow error
 *   (possibly indicating an error in writing `when` condition expressions).
 * 
 * * **all_non_null**
 * 
 *   For the first level of a list input, pick all non-null values.
 *   The result is a list, which may be empty.  Examples:
 * 
 *   * `[null, x, null] -> [x]`
 *   * `[x, null, y] -> [x, y]`
 *   * `[null, [x], [null]] -> [[x], [null]]`
 *   * `[null, null, null] -> []`
 * 
 *   *Intended use case*: It is valid to have more than one source, but
 *    sources are conditional, so null sources (from skipped steps)
 *    should be filtered out.
 */
class WorkflowStepInput : RecordSchemaBase
{
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Specifies one or more workflow parameters that will provide input to
     * the underlying step parameter.
     */
    @link() Union!(None, string, string[]) source_;
    /**
     * The method to use to merge multiple inbound links into a single array.
     * If not specified, the default method is "merge_nested".
     */
    @defaultValue(q"<"merge_nested">") LinkMergeMethod linkMerge_;
    /**
     * The method to use to choose non-null elements among multiple sources.
     */
    Union!(None, PickValueMethod) pickValue_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * If true, the file (or each file in the array) must be a UTF-8
     * text file 64 KiB or smaller, and the implementation must read
     * the entire contents of the file (or file array) and place it
     * in the `contents` field of the File object for use by
     * expressions.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     */
    Union!(None, bool) loadContents_;
    /**
     * Only valid when `type: Directory` or is an array of `items: Directory`.
     * 
     * Specify the desired behavior for loading the `listing` field of
     * a Directory object for use by expressions.
     * 
     * The order of precedence for loadListing is:
     * 
     *   1. `loadListing` on an individual parameter
     *   2. Inherited from `LoadListingRequirement`
     *   3. By default: `no_listing`
     */
    Union!(None, LoadListingEnum) loadListing_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * The default value for this parameter to use if either there is no
     * `source` field, or the value produced by the `source` is `null`.  The
     * default must be applied prior to scattering or evaluating `valueFrom`.
     */
    Union!(None, CWLObjectType) default_;
    /**
     * To use valueFrom, [StepInputExpressionRequirement](#StepInputExpressionRequirement) must
     * be specified in the workflow or workflow step requirements.
     * 
     * If `valueFrom` is a constant string value, use this as the value for
     * this input parameter.
     * 
     * If `valueFrom` is a parameter reference or expression, it must be
     * evaluated to yield the actual value to be assigned to the input field.
     * 
     * The `self` value in the parameter reference or expression must be
     * 1. `null` if there is no `source` field
     * 2. the value of the parameter(s) specified in the `source` field when this
     * workflow input parameter **is not** specified in this workflow step's `scatter` field.
     * 3. an element of the parameter specified in the `source` field when this workflow input
     * parameter **is** specified in this workflow step's `scatter` field.
     * 
     * The value of `inputs` in the parameter reference or expression must be
     * the input object to the workflow step after assigning the `source`
     * values, applying `default`, and then scattering.  The order of
     * evaluating `valueFrom` among step input parameters is undefined and the
     * result of evaluating `valueFrom` on a parameter must not be visible to
     * evaluation of `valueFrom` on other parameters.
     */
    Union!(None, string, Expression) valueFrom_;

    mixin genBody;
}

/**
 * Associate an output parameter of the underlying process with a workflow
 * parameter.  The workflow parameter (given in the `id` field) be may be used
 * as a `source` to connect with input parameters of other workflow steps, or
 * with an output parameter of the process.
 * 
 * A unique identifier for this workflow output parameter.  This is
 * the identifier to use in the `source` field of `WorkflowStepInput`
 * to connect the output value to downstream parameters.
 */
class WorkflowStepOutput : RecordSchemaBase
{
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;

    mixin genBody;
}

/**
 * The scatter method, as described in [workflow step scatter](#WorkflowStep).
 */
class ScatterMethod : EnumSchemaBase
{
    ///
    enum Symbol
    {
        s0 = "dotproduct", ///
        s1 = "nested_crossproduct", ///
        s2 = "flat_crossproduct", ///
    }

    Symbol value;

    mixin genBody;
}

/**
 * A workflow step is an executable element of a workflow.  It specifies the
 * underlying process implementation (such as `CommandLineTool` or another
 * `Workflow`) in the `run` field and connects the input and output parameters
 * of the underlying process to workflow parameters.
 * 
 * # Scatter/gather
 * 
 * To use scatter/gather,
 * [ScatterFeatureRequirement](#ScatterFeatureRequirement) must be specified
 * in the workflow or workflow step requirements.
 * 
 * A "scatter" operation specifies that the associated workflow step or
 * subworkflow should execute separately over a list of input elements.  Each
 * job making up a scatter operation is independent and may be executed
 * concurrently.
 * 
 * The `scatter` field specifies one or more input parameters which will be
 * scattered.  An input parameter may be listed more than once.  The declared
 * type of each input parameter implicitly becomes an array of items of the
 * input parameter type.  If a parameter is listed more than once, it becomes
 * a nested array.  As a result, upstream parameters which are connected to
 * scattered parameters must be arrays.
 * 
 * All output parameter types are also implicitly wrapped in arrays.  Each job
 * in the scatter results in an entry in the output array.
 * 
 * If any scattered parameter runtime value is an empty array, all outputs are
 * set to empty arrays and no work is done for the step, according to
 * applicable scattering rules.
 * 
 * If `scatter` declares more than one input parameter, `scatterMethod`
 * describes how to decompose the input into a discrete set of jobs.
 * 
 *   * **dotproduct** specifies that each of the input arrays are aligned and one
 *       element taken from each array to construct each job.  It is an error
 *       if all input arrays are not the same length.
 * 
 *   * **nested_crossproduct** specifies the Cartesian product of the inputs,
 *       producing a job for every combination of the scattered inputs.  The
 *       output must be nested arrays for each level of scattering, in the
 *       order that the input arrays are listed in the `scatter` field.
 * 
 *   * **flat_crossproduct** specifies the Cartesian product of the inputs,
 *       producing a job for every combination of the scattered inputs.  The
 *       output arrays must be flattened to a single level, but otherwise listed in the
 *       order that the input arrays are listed in the `scatter` field.
 * 
 * # Conditional execution (Optional)
 * 
 * Conditional execution makes execution of a step conditional on an
 * expression.  A step that is not executed is "skipped".  A skipped
 * step produces `null` for all output parameters.
 * 
 * The condition is evaluated after `scatter`, using the input object
 * of each individual scatter job.  This means over a set of scatter
 * jobs, some may be executed and some may be skipped.  When the
 * results are gathered, skipped steps must be `null` in the output
 * arrays.
 * 
 * The `when` field controls conditional execution.  This is an
 * expression that must be evaluated with `inputs` bound to the step
 * input object (or individual scatter job), and returns a boolean
 * value.  It is an error if this expression returns a value other
 * than `true` or `false`.
 * 
 * Conditionals in CWL are an optional feature and are not required
 * to be implemented by all consumers of CWL documents.  An
 * implementation that does not support conditionals must return a
 * fatal error when attempting to execute a workflow that uses
 * conditional constructs the implementation does not support.
 * 
 * # Subworkflows
 * 
 * To specify a nested workflow as part of a workflow step,
 * [SubworkflowFeatureRequirement](#SubworkflowFeatureRequirement) must be
 * specified in the workflow or workflow step requirements.
 * 
 * It is a fatal error if a workflow directly or indirectly invokes itself as
 * a subworkflow (recursive workflows are not allowed).
 */
class WorkflowStep : RecordSchemaBase
{
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * Defines the input parameters of the workflow step.  The process is ready to
     * run when all required input parameters are associated with concrete
     * values.  Input parameters include a schema for each parameter which is
     * used to validate the input object.  It may also be used build a user
     * interface for constructing the input object.
     */
    @idMap("id", "source") WorkflowStepInput[] in_;
    /**
     * Defines the parameters representing the output of the process.  May be
     * used to generate and/or validate the output object.
     */
    @link(LinkResolver.id) Union!(string, WorkflowStepOutput)[] out_;
    /**
     * Declares requirements that apply to either the runtime environment or the
     * workflow engine that must be met in order to execute this workflow step.  If
     * an implementation cannot satisfy all requirements, or a requirement is
     * listed which is not recognized by the implementation, it is a fatal
     * error and the implementation must not attempt to run the process,
     * unless overridden at user option.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this workflow step.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Any[]) hints_;
    /**
     * Specifies the process to run.  If `run` is a string, it must be an absolute IRI
     * or a relative path from the primary document.
     */
    @link() Union!(string, CommandLineTool, ExpressionTool, Workflow, Operation) run_;
    /**
     * If defined, only run the step when the expression evaluates to
     * `true`.  If `false` the step is skipped.  A skipped step
     * produces a `null` on each output.
     */
    Union!(None, Expression) when_;
    ///
    @link() Union!(None, string, string[]) scatter_;
    /**
     * Required if `scatter` is an array of more than one element.
     */
    Union!(None, ScatterMethod) scatterMethod_;

    mixin genBody;
}

/**
 * A workflow describes a set of **steps** and the **dependencies** between
 * those steps.  When a step produces output that will be consumed by a
 * second step, the first step is a dependency of the second step.
 * 
 * When there is a dependency, the workflow engine must execute the preceding
 * step and wait for it to successfully produce output before executing the
 * dependent step.  If two steps are defined in the workflow graph that
 * are not directly or indirectly dependent, these steps are **independent**,
 * and may execute in any order or execute concurrently.  A workflow is
 * complete when all steps have been executed.
 * 
 * Dependencies between parameters are expressed using the `source`
 * field on [workflow step input parameters](#WorkflowStepInput) and
 * `outputSource` field on [workflow output
 * parameters](#WorkflowOutputParameter).
 * 
 * The `source` field on each workflow step input parameter expresses
 * the data links that contribute to the value of the step input
 * parameter (the "sink").  A workflow step can only begin execution
 * when every data link connected to a step has been fulfilled.
 * 
 * The `outputSource` field on each workflow step input parameter
 * expresses the data links that contribute to the value of the
 * workflow output parameter (the "sink").  Workflow execution cannot
 * complete successfully until every data link connected to an output
 * parameter has been fulfilled.
 * 
 * ## Workflow success and failure
 * 
 * A completed step must result in one of `success`, `temporaryFailure` or
 * `permanentFailure` states.  An implementation may choose to retry a step
 * execution which resulted in `temporaryFailure`.  An implementation may
 * choose to either continue running other steps of a workflow, or terminate
 * immediately upon `permanentFailure`.
 * 
 * * If any step of a workflow execution results in `permanentFailure`, then
 * the workflow status is `permanentFailure`.
 * 
 * * If one or more steps result in `temporaryFailure` and all other steps
 * complete `success` or are not executed, then the workflow status is
 * `temporaryFailure`.
 * 
 * * If all workflow steps are executed and complete with `success`, then the
 * workflow status is `success`.
 * 
 * # Extensions
 * 
 * [ScatterFeatureRequirement](#ScatterFeatureRequirement) and
 * [SubworkflowFeatureRequirement](#SubworkflowFeatureRequirement) are
 * available as standard [extensions](#Extensions_and_Metadata) to core
 * workflow semantics.
 */
@documentRoot class Workflow : RecordSchemaBase
{
    /**
     * The unique identifier for this object.
     * 
     * Only useful for `$graph` at `Process` level. Should not be exposed
     * to users in graphical or terminal user interfaces.
     */
    @id Union!(None, string) id_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * Defines the input parameters of the process.  The process is ready to
     * run when all required input parameters are associated with concrete
     * values.  Input parameters include a schema for each parameter which is
     * used to validate the input object.  It may also be used to build a user
     * interface for constructing the input object.
     * 
     * When accepting an input object, all input parameters must have a value.
     * If an input parameter is missing from the input object, it must be
     * assigned a value of `null` (or the value of `default` for that
     * parameter, if provided) for the purposes of validation and evaluation
     * of expressions.
     */
    @idMap("id", "type") WorkflowInputParameter[] inputs_;
    /**
     * Defines the parameters representing the output of the process.  May be
     * used to generate and/or validate the output object.
     */
    @idMap("id", "type") WorkflowOutputParameter[] outputs_;
    /**
     * Declares requirements that apply to either the runtime environment or the
     * workflow engine that must be met in order to execute this process.  If
     * an implementation cannot satisfy all requirements, or a requirement is
     * listed which is not recognized by the implementation, it is a fatal
     * error and the implementation must not attempt to run the process,
     * unless overridden at user option.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this process.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) hints_;
    /**
     * CWL document version. Always required at the document root. Not
     * required for a Process embedded inside another Process.
     */
    Union!(None, CWLVersion) cwlVersion_;
    /**
     * An identifier for the type of computational operation, of this Process.
     * Especially useful for [`Operation`](Workflow.html#Operation), but can also be used for
     * [`CommandLineTool`](CommandLineTool.html#CommandLineTool),
     * [`Workflow`](Workflow.html#Workflow), or [ExpressionTool](Workflow.html#ExpressionTool).
     * 
     * If provided, then this must be an IRI of a concept node that
     * represents the type of operation, preferably defined within an ontology.
     * 
     * For example, in the domain of bioinformatics, one can use an IRI from
     * the EDAM Ontology's [Operation concept nodes](http://edamontology.org/operation_0004),
     * like [Alignment](http://edamontology.org/operation_2928),
     * or [Clustering](http://edamontology.org/operation_3432); or a more
     * specific Operation concept like
     * [Split read mapping](http://edamontology.org/operation_3199).
     */
    @link(LinkResolver.id) Union!(None, string[]) intent_;
    ///
    static immutable class_ = "Workflow";
    /**
     * The individual steps that make up the workflow.  Each step is executed when all of its
     * input data links are fulfilled.  An implementation may choose to execute
     * the steps in a different order than listed and/or execute steps
     * concurrently, provided that dependencies between steps are met.
     */
    @idMap("id") WorkflowStep[] steps_;

    mixin genBody;
}

/**
 * Indicates that the workflow platform must support nested workflows in
 * the `run` field of [WorkflowStep](#WorkflowStep).
 */
class SubworkflowFeatureRequirement : RecordSchemaBase
{
    /**
     * Always 'SubworkflowFeatureRequirement'
     */
    static immutable class_ = "SubworkflowFeatureRequirement";

    mixin genBody;
}

/**
 * Indicates that the workflow platform must support the `scatter` and
 * `scatterMethod` fields of [WorkflowStep](#WorkflowStep).
 */
class ScatterFeatureRequirement : RecordSchemaBase
{
    /**
     * Always 'ScatterFeatureRequirement'
     */
    static immutable class_ = "ScatterFeatureRequirement";

    mixin genBody;
}

/**
 * Indicates that the workflow platform must support multiple inbound data links
 * listed in the `source` field of [WorkflowStepInput](#WorkflowStepInput).
 */
class MultipleInputFeatureRequirement : RecordSchemaBase
{
    /**
     * Always 'MultipleInputFeatureRequirement'
     */
    static immutable class_ = "MultipleInputFeatureRequirement";

    mixin genBody;
}

/**
 * Indicate that the workflow platform must support the `valueFrom` field
 * of [WorkflowStepInput](#WorkflowStepInput).
 */
class StepInputExpressionRequirement : RecordSchemaBase
{
    /**
     * Always 'StepInputExpressionRequirement'
     */
    static immutable class_ = "StepInputExpressionRequirement";

    mixin genBody;
}

/**
 * Describe an input parameter of an operation.
 */
class OperationInputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This must be one or more IRIs of concept nodes
     * that represents file formats which are allowed as input to this
     * parameter, preferably defined within an ontology.  If no ontology is
     * available, file formats may be tested by exact match.
     */
    @link(LinkResolver.id) Union!(None, string, string[], Expression) format_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * If true, the file (or each file in the array) must be a UTF-8
     * text file 64 KiB or smaller, and the implementation must read
     * the entire contents of the file (or file array) and place it
     * in the `contents` field of the File object for use by
     * expressions.  If the size of the file is greater than 64 KiB,
     * the implementation must raise a fatal error.
     */
    Union!(None, bool) loadContents_;
    /**
     * Only valid when `type: Directory` or is an array of `items: Directory`.
     * 
     * Specify the desired behavior for loading the `listing` field of
     * a Directory object for use by expressions.
     * 
     * The order of precedence for loadListing is:
     * 
     *   1. `loadListing` on an individual parameter
     *   2. Inherited from `LoadListingRequirement`
     *   3. By default: `no_listing`
     */
    Union!(None, LoadListingEnum) loadListing_;
    /**
     * The default value to use for this parameter if the parameter is missing
     * from the input object, or if the value of the parameter in the input
     * object is `null`.  Default values are applied before evaluating expressions
     * (e.g. dependent `valueFrom` fields).
     */
    Union!(None, CWLObjectType) default_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string, Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string)[]) type_;

    mixin genBody;
}

/**
 * Describe an output parameter of an operation.
 */
class OperationOutputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or
     * directories that should be included alongside the primary
     * file.  Secondary files may be required or optional.  When not
     * explicitly specified, secondary files specified for `inputs`
     * are required and `outputs` are optional.  An implementation
     * must include matching Files and Directories in the
     * `secondaryFiles` property of the primary file.  These Files
     * and Directories must be transferred and staged alongside the
     * primary file.  An implementation may fail workflow execution
     * if a required secondary file does not exist.
     * 
     * If the value is an expression, the value of `self` in the expression
     * must be the primary input or output File object to which this binding
     * applies.  The `basename`, `nameroot` and `nameext` fields must be
     * present in `self`.  For `CommandLineTool` outputs the `path` field must
     * also be present.  The expression must return a filename string relative
     * to the path to the primary File, a File or Directory object with either
     * `path` or `location` and `basename` fields set, or an array consisting
     * of strings or File or Directory objects.  It is legal to reference an
     * unchanged File or Directory object taken from input as a secondaryFile.
     * The expression may return "null" in which case there is no secondaryFile
     * from that expression.
     * 
     * To work on non-filename-preserving storage systems, portable tool
     * descriptions should avoid constructing new values from `location`, but
     * should construct relative references using `basename` or `nameroot`
     * instead.
     * 
     * If a value in `secondaryFiles` is a string that is not an expression,
     * it specifies that the following pattern should be applied to the path
     * of the primary file to yield a filename relative to the primary File:
     * 
     *   1. If string ends with `?` character, remove the last `?` and mark
     *     the resulting secondary file as optional.
     *   2. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   3. Append the remainder of the string to the end of the file path.
     */
    @secondaryFilesDSL Union!(None, SecondaryFileSchema, SecondaryFileSchema[]) secondaryFiles_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * A value of `true` indicates that the file is read or written
     * sequentially without seeking.  An implementation may use this flag to
     * indicate whether it is valid to stream file contents using a named
     * pipe.  Default: `false`.
     */
    @defaultValue(q"<false>") bool streamable_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this object.
     */
    @id Union!(None, string) id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to the output
     * File object.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string, Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string)[]) type_;

    mixin genBody;
}

/**
 * This record describes an abstract operation.  It is a potential
 * step of a workflow that has not yet been bound to a concrete
 * implementation.  It specifies an input and output signature, but
 * does not provide enough information to be executed.  An
 * implementation (or other tooling) may provide a means of binding
 * an Operation to a concrete process (such as Workflow,
 * CommandLineTool, or ExpressionTool) with a compatible signature.
 */
@documentRoot class Operation : RecordSchemaBase
{
    /**
     * The unique identifier for this object.
     * 
     * Only useful for `$graph` at `Process` level. Should not be exposed
     * to users in graphical or terminal user interfaces.
     */
    @id Union!(None, string) id_;
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * A documentation string for this object, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * Defines the input parameters of the process.  The process is ready to
     * run when all required input parameters are associated with concrete
     * values.  Input parameters include a schema for each parameter which is
     * used to validate the input object.  It may also be used to build a user
     * interface for constructing the input object.
     * 
     * When accepting an input object, all input parameters must have a value.
     * If an input parameter is missing from the input object, it must be
     * assigned a value of `null` (or the value of `default` for that
     * parameter, if provided) for the purposes of validation and evaluation
     * of expressions.
     */
    @idMap("id", "type") OperationInputParameter[] inputs_;
    /**
     * Defines the parameters representing the output of the process.  May be
     * used to generate and/or validate the output object.
     */
    @idMap("id", "type") OperationOutputParameter[] outputs_;
    /**
     * Declares requirements that apply to either the runtime environment or the
     * workflow engine that must be met in order to execute this process.  If
     * an implementation cannot satisfy all requirements, or a requirement is
     * listed which is not recognized by the implementation, it is a fatal
     * error and the implementation must not attempt to run the process,
     * unless overridden at user option.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this process.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, LoadListingRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, WorkReuse, NetworkAccess, InplaceUpdateRequirement, ToolTimeLimit, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) hints_;
    /**
     * CWL document version. Always required at the document root. Not
     * required for a Process embedded inside another Process.
     */
    Union!(None, CWLVersion) cwlVersion_;
    /**
     * An identifier for the type of computational operation, of this Process.
     * Especially useful for [`Operation`](Workflow.html#Operation), but can also be used for
     * [`CommandLineTool`](CommandLineTool.html#CommandLineTool),
     * [`Workflow`](Workflow.html#Workflow), or [ExpressionTool](Workflow.html#ExpressionTool).
     * 
     * If provided, then this must be an IRI of a concept node that
     * represents the type of operation, preferably defined within an ontology.
     * 
     * For example, in the domain of bioinformatics, one can use an IRI from
     * the EDAM Ontology's [Operation concept nodes](http://edamontology.org/operation_0004),
     * like [Alignment](http://edamontology.org/operation_2928),
     * or [Clustering](http://edamontology.org/operation_3432); or a more
     * specific Operation concept like
     * [Split read mapping](http://edamontology.org/operation_3199).
     */
    @link(LinkResolver.id) Union!(None, string[]) intent_;
    ///
    static immutable class_ = "Operation";

    mixin genBody;
}

///
alias DocumentRootType = Union!(CommandLineTool, ExpressionTool, Workflow, Operation);

///
alias importFromURI = import_!DocumentRootType;

@("Test for generated parser")
unittest
{
    import std : dirEntries, SpanMode, stdThreadLocalLog, NullLogger;

    auto currentLogger = stdThreadLocalLog;
    stdThreadLocalLog = new NullLogger;
    scope(exit) stdThreadLocalLog = currentLogger;

    auto resourceDir = "resources/cwl-v1.2";
    foreach (file; dirEntries(resourceDir, SpanMode.depth))
    {
        import std : assertNotThrown, baseName, format, startsWith;
        import salad.resolver : absoluteURI;

        if (!file.baseName.startsWith("valid"))
        {
            continue;
        }
        importFromURI(file.absoluteURI).assertNotThrown(format!"Failed to load %s"(file));
    }
}
