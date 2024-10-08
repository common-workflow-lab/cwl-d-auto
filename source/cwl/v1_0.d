/**
 * CWL v1.0 parser generated with schema-salad-tool
 * 
 * This module was generated using schema-salad code generator.
 * 
 * The embedded document is subject to the license of the original schema.
 * 
 * License: Apache-2.0
 * Date: 2024-09-26
 */
module cwl.v1_0;

import salad.meta.impl : genBody_;
import salad.meta.parser : import_ = importFromURI;
import salad.meta.uda : defaultValue, documentRoot, id, idMap, link, LinkResolver, secondaryFilesDSL, typeDSL;
import salad.primitives : EnumSchemaBase, MapSchemaBase, RecordSchemaBase, UnionSchemaBase;
import salad.type : None, Union;

/// parser information
enum parserInfo = "CWL v1.0 parser generated with schema-salad-tool";

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
 * The `location` property of a File is a URI that uniquely identifies the
 * file.  Implementations must support the file:// URI scheme and may support
 * other schemes such as http://.  The value of `location` may also be a
 * relative reference, in which case it must be resolved relative to the URI
 * of the document it appears in.  Alternately to `location`, implementations
 * must also accept the `path` property on File, which must be a filesystem
 * path available on the same host as the CWL runner (for inputs) or the
 * runtime environment of a command line tool execution (for command line tool
 * outputs).
 * 
 * If no `location` or `path` is specified, a file object must specify
 * `contents` with the UTF-8 text content of the file.  This is a "file
 * literal".  File literals do not correspond to external resources, but are
 * created on disk with `contents` with when needed for a executing a tool.
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
 * File objects in the output must provide either a `location` URI or a `path`
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
     * executed must be able to to access the file at `path` using the POSIX
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
     * period.  For the purposess of path splitting leading periods on the
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
     * Optional hash code for validating file integrity.  Currently must be in the form
     * "sha1$ + hexadecimal string" using the SHA-1 algorithm.
     */
    Union!(None, string) checksum_;
    /**
     * Optional file size
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
    Union!(None, Union!(File, Directory)[]) secondaryFiles_;
    /**
     * The format of the file: this must be an IRI of a concept node that
     * represents the file format, preferrably defined within an ontology.
     * If no ontology is available, file formats may be tested by exact match.
     * 
     * Reasoning about format compatability must be done by checking that an
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
     * File contents literal.  Maximum of 64 KiB.
     * 
     * If neither `location` nor `path` is provided, `contents` must be
     * non-null.  The implementation must assign a unique identifier for the
     * `location` field.  When the file is staged as input to CommandLineTool,
     * the value of `contents` must be written to a file.
     * 
     * If `loadContents` of `inputBinding` or `outputBinding` is true and
     * `location` is valid, the implementation must read up to the first 64
     * KiB of text from the file and place it in the "contents" field.
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
 * The `location` property of a Directory is a URI that uniquely identifies
 * the directory.  Implementations must support the file:// URI scheme and may
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
 * first and have local values of `path` assigend.
 * 
 * Directory objects in CommandLineTool output must provide either a
 * `location` URI or a `path` property in the context of the tool execution
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
     * executed must be able to to access the directory at `path` using the POSIX
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
 * Type representing a valid CWL input file as a `map<string, CWLObjectType>`.
 */
class CWLInputFile : MapSchemaBase
{
    CWLObjectType[string] payload;

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
    }

    Symbol value;

    mixin genBody;
}

///
public import salad.primitives : Expression;

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
    ///
    Union!(None, CommandLineBinding) inputBinding_;
    /**
     * A short, human-readable label of this process object.
     */
    Union!(None, string) label_;

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
    ///
    @id Union!(None, string) name_;

    mixin genBody;
}

///
class InputEnumSchema : RecordSchemaBase
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
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    ///
    Union!(None, CommandLineBinding) inputBinding_;

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
    ///
    Union!(None, CommandLineBinding) inputBinding_;

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
    ///
    Union!(None, CommandOutputBinding) outputBinding_;

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

    mixin genBody;
}

///
class OutputEnumSchema : RecordSchemaBase
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
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    ///
    Union!(None, CommandOutputBinding) outputBinding_;

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
    ///
    Union!(None, CommandOutputBinding) outputBinding_;

    mixin genBody;
}

///
class InputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or directories that
     * must be included alongside the primary file.  All listed secondary
     * files must be present.  An implementation may fail workflow execution
     * if an expected secondary file does not exist.
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
     *   1. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   2. Append the remainder of the string to the end of the file path.
     */
    Union!(None, string, Expression, Union!(string, Expression)[]) secondaryFiles_;
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
     * A documentation string for this type, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this parameter object.
     */
    @id string id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This must be one or more IRIs of concept nodes
     * that represents file formats which are allowed as input to this
     * parameter, preferrably defined within an ontology.  If no ontology is
     * available, file formats may be tested by exact match.
     */
    @link(LinkResolver.id) Union!(None, string, string[], Expression) format_;
    /**
     * Describes how to handle the inputs of a process and convert them
     * into a concrete form for execution, such as command line parameters.
     */
    Union!(None, CommandLineBinding) inputBinding_;
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
    @typeDSL Union!(None, CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string, Union!(CWLType, InputRecordSchema, InputEnumSchema, InputArraySchema, string)[]) type_;

    mixin genBody;
}

///
class OutputParameter : RecordSchemaBase
{
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Provides a pattern or expression specifying files or directories that
     * must be included alongside the primary file.  All listed secondary
     * files must be present.  An implementation may fail workflow execution
     * if an expected secondary file does not exist.
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
     *   1. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   2. Append the remainder of the string to the end of the file path.
     */
    Union!(None, string, Expression, Union!(string, Expression)[]) secondaryFiles_;
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
     * A documentation string for this type, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this parameter object.
     */
    @id string id_;
    /**
     * Describes how to handle the outputs of a process.
     */
    Union!(None, CommandOutputBinding) outputBinding_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to
     * the output parameter.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;

    mixin genBody;
}

/**
 * Indicates that the workflow platform must support inline Javascript expressions.
 * If this requirement is not present, the workflow platform must not perform expression
 * interpolatation.
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
 * contain a IRI, the implementation must check if the type is defined in
 * `schemaDefs` and use that definition.  If the type is not found in
 * `schemaDefs`, it is an error.  The entries in `schemaDefs` must be
 * processed in the order listed such that later schema definitions may refer
 * to earlier schema definitions.
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
    Union!(InputRecordSchema, InputEnumSchema, InputArraySchema)[] types_;

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
 * "value" refers to the the corresponding value in the input object.  For
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
 *       items.  Otherwise first add `prefix`, then recursively process
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
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * Read up to the first 64 KiB of text from the file and place it in the
     * "contents" field of the file object for use by expressions.
     */
    Union!(None, bool) loadContents_;
    /**
     * The sorting key.  Default position is 0.
     */
    @defaultValue(q"<0>") int position_;
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
     * separated by by `itemSeparator`.
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
     * Find files relative to the output directory, using POSIX glob(3)
     * pathname matching.  If an array is provided, find files that match any
     * pattern in the array.  If an expression is provided, the expression must
     * return a string or an array of strings, which will then be evaluated as
     * one or more glob patterns.  Must only match and return files which
     * actually exist.
     */
    Union!(None, string, Expression, string[]) glob_;
    /**
     * For each file matched in `glob`, read up to
     * the first 64 KiB of text from the file and place it in the `contents`
     * field of the file object for manipulation by `outputEval`.
     */
    Union!(None, bool) loadContents_;
    /**
     * Evaluate an expression to generate the output value.  If `glob` was
     * specified, the value of `self` must be an array containing file objects
     * that were matched.  If no files were matched, `self` must be a zero
     * length array; if a single file was matched, the value of `self` is an
     * array of a single element.  Additionally, if `loadContents` is `true`,
     * the File objects must include up to the first 64 KiB of file contents
     * in the `contents` field.
     */
    Union!(None, string, Expression) outputEval_;

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
    ///
    Union!(None, CommandLineBinding) inputBinding_;
    /**
     * A short, human-readable label of this process object.
     */
    Union!(None, string) label_;

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
    ///
    @id Union!(None, string) name_;

    mixin genBody;
}

///
class CommandInputEnumSchema : RecordSchemaBase
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
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    ///
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
    ///
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
    ///
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
    ///
    @id Union!(None, string) name_;

    mixin genBody;
}

///
class CommandOutputEnumSchema : RecordSchemaBase
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
    /**
     * A short, human-readable label of this object.
     */
    Union!(None, string) label_;
    ///
    Union!(None, CommandOutputBinding) outputBinding_;

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
    ///
    Union!(None, CommandOutputBinding) outputBinding_;

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
     * Provides a pattern or expression specifying files or directories that
     * must be included alongside the primary file.  All listed secondary
     * files must be present.  An implementation may fail workflow execution
     * if an expected secondary file does not exist.
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
     *   1. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   2. Append the remainder of the string to the end of the file path.
     */
    Union!(None, string, Expression, Union!(string, Expression)[]) secondaryFiles_;
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
     * A documentation string for this type, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this parameter object.
     */
    @id string id_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This must be one or more IRIs of concept nodes
     * that represents file formats which are allowed as input to this
     * parameter, preferrably defined within an ontology.  If no ontology is
     * available, file formats may be tested by exact match.
     */
    @link(LinkResolver.id) Union!(None, string, string[], Expression) format_;
    /**
     * Describes how to handle the inputs of a process and convert them
     * into a concrete form for execution, such as command line parameters.
     */
    Union!(None, CommandLineBinding) inputBinding_;
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
    @typeDSL Union!(None, CWLType, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string, Union!(CWLType, CommandInputRecordSchema, CommandInputEnumSchema, CommandInputArraySchema, string)[]) type_;

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
     * Provides a pattern or expression specifying files or directories that
     * must be included alongside the primary file.  All listed secondary
     * files must be present.  An implementation may fail workflow execution
     * if an expected secondary file does not exist.
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
     *   1. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   2. Append the remainder of the string to the end of the file path.
     */
    Union!(None, string, Expression, Union!(string, Expression)[]) secondaryFiles_;
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
     * A documentation string for this type, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this parameter object.
     */
    @id string id_;
    /**
     * Describes how to handle the outputs of a process.
     */
    Union!(None, CommandOutputBinding) outputBinding_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to
     * the output parameter.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(None, CWLType, stdout, stderr, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string, Union!(CWLType, CommandOutputRecordSchema, CommandOutputEnumSchema, CommandOutputArraySchema, string)[]) type_;

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
     * The unique identifier for this process object.
     */
    @id Union!(None, string) id_;
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
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this process.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) hints_;
    /**
     * A short, human-readable label of this process object.
     */
    Union!(None, string) label_;
    /**
     * A long, human-readable description of this process object.
     */
    Union!(None, string) doc_;
    /**
     * CWL document version. Always required at the document root. Not
     * required for a Process embedded inside another Process.
     */
    Union!(None, CWLVersion) cwlVersion_;
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
     * Command line bindings which are not directly associated with input parameters.
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
     */
    Union!(None, int[]) successCodes_;
    /**
     * Exit codes that indicate the process failed due to a possibly
     * temporary condition, where executing the process with the same
     * runtime environment and inputs may produce different results.
     */
    Union!(None, int[]) temporaryFailCodes_;
    /**
     * Exit codes that indicate the process failed due to a permanent logic error, where executing the process with the same runtime environment and same inputs is expected to always fail.
     */
    Union!(None, int[]) permanentFailCodes_;

    mixin genBody;
}

/**
 * Indicates that a workflow component should be run in a
 * [Docker](http://docker.com) container, and specifies how to fetch or build
 * the image.
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
 * within the container.
 * 
 * When running a tool contained in Docker, the workflow platform must not
 * assume anything about the contents of the Docker container, such as the
 * presence or absence of specific software, except to assume that the
 * generated command line represents a valid command within the runtime
 * environment of the container.
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
     * Specify a Docker image to retrieve using `docker pull`.
     */
    Union!(None, string) dockerPull_;
    /**
     * Specify a HTTP URL from which to download a Docker image using `docker load`.
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
     * these software identifer IRIs to some configuration action; or they can
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
     * could be fulfilled using the above mentioned Debian or bioconda
     * package, a local installation managed by [Environement Modules](http://modules.sourceforge.net/),
     * or any other mechanism the platform chooses. IRIs can also be from
     * identifer sources that are discipline specific yet still system
     * independent. As an example, the equivalent [ELIXIR Tools and Data
     * Service Registry](https://bio.tools) IRI to the previous RRID example is
     * https://bio.tools/tool/bowtie2/version/2.2.8.
     * If supported by a given registry, implementations are encouraged to
     * query these system independent sofware identifier IRIs directly for
     * links to packaging systems.
     * 
     * A site specific IRI can be listed as well. For example, an academic
     * computing cluster using Environement Modules could list the IRI
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
 * Define a file or subdirectory that must be placed in the designated output
 * directory prior to executing the command line tool.  May be the result of
 * executing an expression, such as building a configuration file from a
 * template.
 */
class Dirent : RecordSchemaBase
{
    /**
     * The name of the file or subdirectory to create in the output directory.
     * If `entry` is a File or Directory, the `entryname` field overrides the value
     * of `basename` of the File or Directory object.  Optional.
     */
    Union!(None, string, Expression) entryname_;
    /**
     * If the value is a string literal or an expression which evaluates to a
     * string, a new file must be created with the string as the file contents.
     * 
     * If the value is an expression that evaluates to a `File` object, this
     * indicates the referenced file should be added to the designated output
     * directory prior to executing the tool.
     * 
     * If the value is an expression that evaluates to a `Dirent` object, this
     * indicates that the File or Directory in `entry` should be added to the
     * designated output directory with the name in `entryname`.
     * 
     * If `writable` is false, the file may be made available using a bind
     * mount or file system link to avoid unnecessary copying of the input
     * file.
     */
    Union!(string, Expression) entry_;
    /**
     * If true, the file or directory must be writable by the tool.  Changes
     * to the file or directory must be isolated and not visible by any other
     * CommandLineTool process.  This may be implemented by making a copy of
     * the original file or directory.  Default false (files and directories
     * read-only by default).
     * 
     * A directory marked as `writable: true` implies that all files and
     * subdirectories are recursively writable as well.
     */
    @defaultValue(q"<false>") bool writable_;

    mixin genBody;
}

/**
 * Define a list of files and subdirectories that must be created by the workflow platform in the designated output directory prior to executing the command line tool.
 */
class InitialWorkDirRequirement : RecordSchemaBase
{
    /**
     * InitialWorkDirRequirement
     */
    static immutable class_ = "InitialWorkDirRequirement";
    /**
     * The list of files or subdirectories that must be placed in the
     * designated output directory prior to executing the command line tool.
     * 
     * May be an expression.  If so, the expression return value must validate
     * as `{type: array, items: [File, Directory]}`.
     * 
     * Files or Directories which are listed in the input parameters and
     * appear in the `InitialWorkDirRequirement` listing must have their
     * `path` set to their staged location in the designated output directory.
     * If the same File or Directory appears more than once in the
     * `InitialWorkDirRequirement` listing, the implementation must choose
     * exactly one value for `path`; how this value is chosen is undefined.
     */
    Union!(Union!(File, Directory, Dirent, string, Expression)[], string, Expression) listing_;

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
 * containing a shell command line.  Each item in the argument list must be
 * joined into a string separated by single spaces and quoted to prevent
 * intepretation by the shell, unless `CommandLineBinding` for that argument
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
 * "min" is the minimum amount of a resource that must be reserved to schedule
 * a job. If "min" cannot be satisfied, the job should not be run.
 * 
 * "max" is the maximum amount of a resource that the job shall be permitted
 * to use. If a node has sufficient resources, multiple jobs may be scheduled
 * on a single node provided each job's "max" resource requirements are
 * met. If a job attempts to exceed its "max" resource allocation, an
 * implementation may deny additional resources, which may result in job
 * failure.
 * 
 * If "min" is specified but "max" is not, then "max" == "min"
 * If "max" is specified by "min" is not, then "min" == "max".
 * 
 * It is an error if max < min.
 * 
 * It is an error if the value of any of these fields is negative.
 * 
 * If neither "min" nor "max" is specified for a resource, an implementation may provide a default.
 */
class ResourceRequirement : RecordSchemaBase
{
    /**
     * Always 'ResourceRequirement'
     */
    static immutable class_ = "ResourceRequirement";
    /**
     * Minimum reserved number of CPU cores
     */
    Union!(None, int, long, string, Expression) coresMin_;
    /**
     * Maximum reserved number of CPU cores
     */
    Union!(None, int, string, Expression) coresMax_;
    /**
     * Minimum reserved RAM in mebibytes (2**20)
     */
    Union!(None, int, long, string, Expression) ramMin_;
    /**
     * Maximum reserved RAM in mebibytes (2**20)
     */
    Union!(None, int, long, string, Expression) ramMax_;
    /**
     * Minimum reserved filesystem based storage for the designated temporary directory, in mebibytes (2**20)
     */
    Union!(None, long, string, Expression) tmpdirMin_;
    /**
     * Maximum reserved filesystem based storage for the designated temporary directory, in mebibytes (2**20)
     */
    Union!(None, int, long, string, Expression) tmpdirMax_;
    /**
     * Minimum reserved filesystem based storage for the designated output directory, in mebibytes (2**20)
     */
    Union!(None, int, long, string, Expression) outdirMin_;
    /**
     * Maximum reserved filesystem based storage for the designated output directory, in mebibytes (2**20)
     */
    Union!(None, int, long, string, Expression) outdirMax_;

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
     * Provides a pattern or expression specifying files or directories that
     * must be included alongside the primary file.  All listed secondary
     * files must be present.  An implementation may fail workflow execution
     * if an expected secondary file does not exist.
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
     *   1. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   2. Append the remainder of the string to the end of the file path.
     */
    Union!(None, string, Expression, Union!(string, Expression)[]) secondaryFiles_;
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
     * A documentation string for this type, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this parameter object.
     */
    @id string id_;
    /**
     * Describes how to handle the outputs of a process.
     */
    Union!(None, CommandOutputBinding) outputBinding_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to
     * the output parameter.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(None, CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string, Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string)[]) type_;

    mixin genBody;
}

/**
 * Execute an expression as a Workflow step.
 */
@documentRoot class ExpressionTool : RecordSchemaBase
{
    /**
     * The unique identifier for this process object.
     */
    @id Union!(None, string) id_;
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
    @idMap("id", "type") InputParameter[] inputs_;
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
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this process.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) hints_;
    /**
     * A short, human-readable label of this process object.
     */
    Union!(None, string) label_;
    /**
     * A long, human-readable description of this process object.
     */
    Union!(None, string) doc_;
    /**
     * CWL document version. Always required at the document root. Not
     * required for a Process embedded inside another Process.
     */
    Union!(None, CWLVersion) cwlVersion_;
    ///
    static immutable class_ = "ExpressionTool";
    /**
     * The expression to execute.  The expression must return a JSON object which
     * matches the output parameters of the ExpressionTool.
     */
    Union!(string, Expression) expression_;

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
 * Describe an output parameter of a workflow.  The parameter must be
 * connected to one or more parameters defined in the workflow that will
 * provide the value of the output parameter.
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
     * Provides a pattern or expression specifying files or directories that
     * must be included alongside the primary file.  All listed secondary
     * files must be present.  An implementation may fail workflow execution
     * if an expected secondary file does not exist.
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
     *   1. If string begins with one or more caret `^` characters, for each
     *     caret, remove the last file extension from the path (the last
     *     period `.` and all following characters).  If there are no file
     *     extensions, the path is unchanged.
     *   2. Append the remainder of the string to the end of the file path.
     */
    Union!(None, string, Expression, Union!(string, Expression)[]) secondaryFiles_;
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
     * A documentation string for this type, or an array of strings which should be concatenated.
     */
    Union!(None, string, string[]) doc_;
    /**
     * The unique identifier for this parameter object.
     */
    @id string id_;
    /**
     * Describes how to handle the outputs of a process.
     */
    Union!(None, CommandOutputBinding) outputBinding_;
    /**
     * Only valid when `type: File` or is an array of `items: File`.
     * 
     * This is the file format that will be assigned to
     * the output parameter.
     */
    @link(LinkResolver.id) Union!(None, string, Expression) format_;
    /**
     * Specifies one or more workflow parameters that supply the value of to
     * the output parameter.
     */
    @link() Union!(None, string, string[]) outputSource_;
    /**
     * The method to use to merge multiple sources into a single array.
     * If not specified, the default method is "merge_nested".
     */
    Union!(None, LinkMergeMethod) linkMerge_;
    /**
     * Specify valid types of data that may be assigned to this parameter.
     */
    @typeDSL Union!(None, CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string, Union!(CWLType, OutputRecordSchema, OutputEnumSchema, OutputArraySchema, string)[]) type_;

    mixin genBody;
}

/**
 * The input of a workflow step connects an upstream parameter (from the
 * workflow inputs, or the outputs of other workflows steps) with the input
 * parameters of the underlying step.
 * 
 * ## Input object
 * 
 * A WorkflowStepInput object must contain an `id` field in the form
 * `#fieldname` or `#prefix/fieldname`.  When the `id` field contains a slash
 * `/` the field name consists of the characters following the final slash
 * (the prefix portion may contain one or more slashes to indicate scope).
 * This defines a field of the workflow step input object with the value of
 * the `source` parameter(s).
 * 
 * ## Merging
 * 
 * To merge multiple inbound data links,
 * [MultipleInputFeatureRequirement](#MultipleInputFeatureRequirement) must be specified
 * in the workflow or workflow step requirements.
 * 
 * If the sink parameter is an array, or named in a [workflow
 * scatter](#WorkflowStep) operation, there may be multiple inbound data links
 * listed in the `source` field.  The values from the input links are merged
 * depending on the method specified in the `linkMerge` field.  If not
 * specified, the default method is "merge_nested".
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
 */
class WorkflowStepInput : RecordSchemaBase
{
    /**
     * Specifies one or more workflow parameters that will provide input to
     * the underlying step parameter.
     */
    @link() Union!(None, string, string[]) source_;
    /**
     * The method to use to merge multiple inbound links into a single array.
     * If not specified, the default method is "merge_nested".
     */
    Union!(None, LinkMergeMethod) linkMerge_;
    /**
     * A unique identifier for this workflow input parameter.
     */
    @id string id_;
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
     * evaluated to yield the actual value to be assiged to the input field.
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
 */
class WorkflowStepOutput : RecordSchemaBase
{
    /**
     * A unique identifier for this workflow output parameter.  This is the
     * identifier to use in the `source` field of `WorkflowStepInput` to
     * connect the output value to downstream parameters.
     */
    @id string id_;

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
 * type of each input parameter is implicitly becomes an array of items of the
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
     * The unique identifier for this workflow step.
     */
    @id string id_;
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
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this workflow step.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Any[]) hints_;
    /**
     * A short, human-readable label of this process object.
     */
    Union!(None, string) label_;
    /**
     * A long, human-readable description of this process object.
     */
    Union!(None, string) doc_;
    /**
     * Specifies the process to run.
     */
    @link() Union!(string, CommandLineTool, ExpressionTool, Workflow) run_;
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
 * Dependencies between parameters are expressed using the `source` field on
 * [workflow step input parameters](#WorkflowStepInput) and [workflow output
 * parameters](#WorkflowOutputParameter).
 * 
 * The `source` field expresses the dependency of one parameter on another
 * such that when a value is associated with the parameter specified by
 * `source`, that value is propagated to the destination parameter.  When all
 * data links inbound to a given step are fufilled, the step is ready to
 * execute.
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
     * The unique identifier for this process object.
     */
    @id Union!(None, string) id_;
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
    @idMap("id", "type") InputParameter[] inputs_;
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
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) requirements_;
    /**
     * Declares hints applying to either the runtime environment or the
     * workflow engine that may be helpful in executing this process.  It is
     * not an error if an implementation cannot satisfy all hints, however
     * the implementation may report a warning.
     */
    @idMap("class") Union!(None, Union!(InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement, SubworkflowFeatureRequirement, ScatterFeatureRequirement, MultipleInputFeatureRequirement, StepInputExpressionRequirement, Any)[]) hints_;
    /**
     * A short, human-readable label of this process object.
     */
    Union!(None, string) label_;
    /**
     * A long, human-readable description of this process object.
     */
    Union!(None, string) doc_;
    /**
     * CWL document version. Always required at the document root. Not
     * required for a Process embedded inside another Process.
     */
    Union!(None, CWLVersion) cwlVersion_;
    ///
    static immutable class_ = "Workflow";
    /**
     * The individual steps that make up the workflow.  Each step is executed when all of its
     * input data links are fufilled.  An implementation may choose to execute
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

///
alias DocumentRootType = Union!(CommandLineTool, ExpressionTool, Workflow);

///
alias importFromURI = import_!DocumentRootType;

@("Test for generated parser")
unittest
{
    import std : dirEntries, SpanMode, stdThreadLocalLog, NullLogger;

    auto currentLogger = stdThreadLocalLog;
    stdThreadLocalLog = new NullLogger;
    scope(exit) stdThreadLocalLog = currentLogger;

    auto resourceDir = "resources/cwl-v1.0";
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
