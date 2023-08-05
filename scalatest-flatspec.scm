      ((infix_expression
        left: (infix_expression
          left: (identifier) @test.describe
          right: (string) @test.name)
        operator: (identifier) @keyword.in (#eq? @keyword.in "in")
        right: (block) @test.body
      )) @test.definition

      ((infix_expression
        left: (infix_expression
          left: (string) @test.describe
          right: (string) @test.name)
        operator: (identifier) @keyword.in (#eq? @keyword.in "in")
        right: (block) @test.body
      )) @test.definition

      ((infix_expression
        left: (infix_expression
          left: (string) @test.describe
          operator: (identifier) @keyword.ignore (#eq? @keyword.ignore "ignore")
        )
      )) @test.ignore

      ((call_expression
        function: (identifier) @keyword.pending (#eq? @keyword.pending "pending")
      )) @test.pending

      ((call_expression
        function: (identifier) @keyword.cancel (#eq? @keyword.cancel "cancel")
      )) @test.cancel

      ((call_expression
        function: (identifier) @keyword.info (#eq? @keyword.info "info")
        arguments: (arguments (string) @test.additional_info)
      )) @test.info

      ((infix_expression
        left: (infix_expression
          left: (string) @test.describe
          operator: (identifier) @keyword.which (#eq? @keyword.which "which")
          right: (string) @test.name)
        operator: (identifier) @keyword.in (#eq? @keyword.in "in")
        right: (block) @test.body
      )) @test.definition_with_which

