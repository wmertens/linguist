require_relative "./helper"

class TestShebang < Test::Unit::TestCase
  include Linguist

  def assert_interpreter(interpreter, body)
    assert_equal interpreter, Shebang.interpreter(body)
  end

  def test_shebangs
    assert_interpreter nil, ""
    assert_interpreter nil, "foo"
    assert_interpreter nil, "#bar"
    assert_interpreter nil, "#baz"
    assert_interpreter nil, "///"
    assert_interpreter nil, "\n\n\n\n\n"
    assert_interpreter nil, " #!/usr/sbin/ruby"
    assert_interpreter nil, "\n#!/usr/sbin/ruby"

    assert_interpreter "ruby", "#!/usr/sbin/ruby\n# bar"
    assert_interpreter "ruby", "#!/usr/bin/ruby\n# foo"
    assert_interpreter "ruby", "#!/usr/sbin/ruby"
    assert_interpreter "ruby", "#!/usr/sbin/ruby foo bar baz\n"

    assert_interpreter "Rscript", "#!/usr/bin/env Rscript\n# example R script\n#\n"
    assert_interpreter "crystal", "#!/usr/bin/env bin/crystal"
    assert_interpreter "ruby", "#!/usr/bin/env ruby\n# baz"

    assert_interpreter "bash", "#!/usr/bin/bash\n"
    assert_interpreter "sh", "#!/bin/sh"
    assert_interpreter "python", "#!/bin/python\n# foo\n# bar\n# baz"
    assert_interpreter "python2", "#!/usr/bin/python2.7\n\n\n\n"
    assert_interpreter "python3", "#!/usr/bin/python3\n\n\n\n"
    assert_interpreter "sbcl", "#!/usr/bin/sbcl --script\n\n"
    assert_interpreter "perl", "#! perl"
  end

end
