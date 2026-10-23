; extends


;; assert

(call
  target: (identifier) @assert
  (#eq? @assert "assert"))


;; describe

(call
  target: (identifier) @describe
  (#eq? @describe "describe"))

(call
  target: (identifier) @describe (#eq? @describe "describe")
  (do_block
    [ "do" "end" ] @describe.do.end))


;; refute

(call
  target: (identifier) @refute
  (#eq? @refute "refute"))


;; setup

(call
  target: (identifier) @setup
  (#eq? @setup "setup"))

(call
  target: (identifier) @setup (#eq? @setup "setup")
  (do_block
    [ "do" "end" ] @setup.do.end))


;; test

(call
  target: (identifier) @test
  (#eq? @test "test"))

(call
  target: (identifier) @test (#eq? @test "test")
  (do_block
    [ "do" "end" ] @test.do.end))


;; test > title

(call
  target: (identifier) @test
  (#eq? @test "test")
  (arguments
    (string
      (quoted_content) @test.title)))
