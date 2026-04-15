; Variables
;----------

(identifier) @variable

; Properties
;-----------

(property_identifier) @property

; Function and method definitions
;--------------------------------

(function_expression
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(method_definition
  name: (property_identifier) @function.method)

(pair
  key: (property_identifier) @function.method
  value: [(function_expression) (arrow_function)])

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: [(function_expression) (arrow_function)])

(variable_declarator
  name: (identifier) @function
  value: [(function_expression) (arrow_function)])

(assignment_expression
  left: (identifier) @function
  right: [(function_expression) (arrow_function)])

; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method))

; Special identifiers
;--------------------

((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

([
    (identifier)
    (shorthand_property_identifier)
    (shorthand_property_identifier_pattern)
 ] @constant
 (#match? @constant "^[A-Z_][A-Z\\d_]+$"))

((identifier) @variable.builtin
 (#match? @variable.builtin "^(arguments|module|console|window|document)$")
 (#is-not? local))

((identifier) @function.builtin
 (#eq? @function.builtin "require")
 (#is-not? local))

; Literals
;---------

(this) @variable.builtin
(super) @variable.builtin

[
  (true)
  (false)
  (null)
  (undefined)
] @constant.builtin

(comment) @comment

[
  (string)
  (template_string)
] @string

(regex) @string.special
(number) @number

; Tokens
;-------

[
  ";"
  (optional_chain)
  "."
  ","
] @punctuation.delimiter

[
  "-"
  "--"
  "-="
  "+"
  "++"
  "+="
  "*"
  "*="
  "**"
  "**="
  "/"
  "/="
  "%"
  "%="
  "<"
  "<="
  "<<"
  "<<="
  "="
  "=="
  "==="
  "!"
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "~"
  "^"
  "&"
  "|"
  "^="
  "&="
  "|="
  "&&"
  "||"
  "??"
  "&&="
  "||="
  "??="
] @operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

[
  "as"
  "async"
  "await"
  "break"
  "case"
  "catch"
  "class"
  "const"
  "continue"
  "debugger"
  "default"
  "delete"
  "do"
  "else"
  "export"
  "extends"
  "finally"
  "for"
  "from"
  "function"
  "get"
  "if"
  "import"
  "in"
  "instanceof"
  "let"
  "new"
  "of"
  "return"
  "set"
  "static"
  "switch"
  "target"
  "throw"
  "try"
  "typeof"
  "var"
  "void"
  "while"
  "with"
  "yield"
] @keyword

; --- TypeScript (extends ECMAScript/JavaScript; merged for Slates/Neon) ---
; Derived from nvim-treesitter queries/typescript/highlights.scm (MIT).

"require" @keyword.import

(import_require_clause
  source: (string) @string.special)

[
  "declare"
  "implements"
  "type"
  "override"
  "module"
  "asserts"
  "infer"
  "is"
  "using"
] @keyword

[
  "namespace"
  "interface"
  "enum"
] @keyword.type

[
  "keyof"
  "satisfies"
] @keyword.operator

(as_expression
  "as" @keyword.operator)

(mapped_type_clause
  "as" @keyword.operator)

[
  "abstract"
  "private"
  "protected"
  "public"
  "readonly"
] @keyword.modifier

(type_identifier) @type

(predefined_type) @type.builtin

(import_statement
  "type"
  (import_clause
    (named_imports
      (import_specifier
        name: (identifier) @type))))

(template_literal_type) @string

(non_null_expression
  "!" @operator)

(type_arguments
  [
    "<"
    ">"
  ] @punctuation.bracket)

(type_parameters
  [
    "<"
    ">"
  ] @punctuation.bracket)

(object_type
  [
    "{|"
    "|}"
  ] @punctuation.bracket)

(union_type
  "|" @punctuation.delimiter)

(intersection_type
  "&" @punctuation.delimiter)

(type_annotation
  ":" @punctuation.delimiter)

(type_predicate_annotation
  ":" @punctuation.delimiter)

(index_signature
  ":" @punctuation.delimiter)

(omitting_type_annotation
  "-?:" @punctuation.delimiter)

(adding_type_annotation
  "+?:" @punctuation.delimiter)

(opting_type_annotation
  "?:" @punctuation.delimiter)

"?." @punctuation.delimiter

(abstract_method_signature
  "?" @punctuation.special)

(method_signature
  "?" @punctuation.special)

(method_definition
  "?" @punctuation.special)

(property_signature
  "?" @punctuation.special)

(optional_parameter
  "?" @punctuation.special)

(optional_type
  "?" @punctuation.special)

(public_field_definition
  [
    "?"
    "!"
  ] @punctuation.special)

(flow_maybe_type
  "?" @punctuation.special)

(template_type
  [
    "${"
    "}"
  ] @punctuation.special)

(conditional_type
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(required_parameter
  pattern: (identifier) @variable.parameter)

(optional_parameter
  pattern: (identifier) @variable.parameter)

(required_parameter
  (rest_pattern
    (identifier) @variable.parameter))

(required_parameter
  (object_pattern
    (shorthand_property_identifier_pattern) @variable.parameter))

(required_parameter
  (object_pattern
    (object_assignment_pattern
      (shorthand_property_identifier_pattern) @variable.parameter)))

(required_parameter
  (object_pattern
    (pair_pattern
      value: (identifier) @variable.parameter)))

(required_parameter
  (array_pattern
    (identifier) @variable.parameter))

(arrow_function
  parameter: (identifier) @variable.parameter)

(ambient_declaration
  "global" @module)

(ambient_declaration
  (function_signature
    name: (identifier) @function))

(method_signature
  name: (_) @function.method)

(abstract_method_signature
  name: (property_identifier) @function.method)

(property_signature
  name: (property_identifier) @function.method
  type: (type_annotation
    [
      (union_type
        (parenthesized_type
          (function_type)))
      (function_type)
    ]))
