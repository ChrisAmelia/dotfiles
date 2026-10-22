; extends

(attribute
  (attribute_name) @name (#eq? @name "class")
  (quoted_attribute_value
    (attribute_value) @attribute.class))

(attribute
  (attribute_name) @name (#eq? @name "id")
  (quoted_attribute_value
    (attribute_value) @attribute.id))

(attribute
  (attribute_name) @attribute_name
  (#match? @attribute_name "^phx-")
  (quoted_attribute_value
    (attribute_value) @string.phx))
