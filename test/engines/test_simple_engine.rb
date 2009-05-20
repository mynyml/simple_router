require 'test/test_helper'

class SimpleEngineTest < Test::Unit::TestCase
  include SimpleRouter::Engines::SimpleEngine

  test "matches static paths" do
    Base.match('/',    ['/', '/foo']).first.should be('/')
    Base.match('/foo', ['/', '/foo']).first.should be('/foo')
    Base.match('/bar', ['/', '/foo']).first.should be(nil)
  end

  test "matches variable paths" do
    path, vars = Base.match('/80/07', ['/foo', '/:year/:month'])
    path.should be('/:year/:month')
    vars.should be(['80','07'])
  end

  test "matches hybrid paths" do
    path, vars = Base.match('/archives/80/07', ['/foo', '/archives/:year/:month'])
    path.should be('/archives/:year/:month')
    vars.should be(['80','07'])
  end

  test "ignores leading slash in path" do
    path, vars = Base.match('archives/80/07', ['/foo', '/archives/:year/:month'])
    path.should be('/archives/:year/:month')
    vars.should be(['80','07'])
  end

  test "no matches" do
    path, vars = Base.match('/80/07/01', ['/foo', '/:year/:month'])
    path.should be(nil)
    vars.should be([])
  end

  test "treats extension as pattern part" do
    path, vars = Base.match('/a/b.xml', ['/:foo/:bar', '/:foo/:bar.:type'])
    path.should be('/:foo/:bar.:type')
    vars.should be(['a','b','xml'])
  end
end

class PatternTest < Test::Unit::TestCase
  include SimpleRouter::Engines::SimpleEngine

  test "static pattern matches a path" do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/foo/bar')

    assert pattern == path
  end

  test "variable pattern matches a path" do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/:foo/:bar')

    assert pattern == path
  end

  test "pattern variables" do
    path    = Path.new('/foo/bar/baz')
    pattern = Pattern.new('/:a/:b/:c')

    assert pattern == path
    pattern.vars.should be(%w( foo bar baz ))
  end

  test "pattern variables with extension" do
    path    = Path.new('/foo/bar/baz.xml')
    pattern = Pattern.new('/:a/:b/:c.:type')

    assert pattern == path
    pattern.vars.should be(%w( foo bar baz xml ))
  end

  test "variable pattern matches a path with static extension" do
    path    = Path.new('/foo/bar.xml')
    pattern = Pattern.new('/:foo/:bar.xml')

    assert pattern == path
  end

  test "variable pattern matches a path with variable extension" do
    path    = Path.new('/foo/bar.xml')
    pattern = Pattern.new('/:foo/:bar.:type')

    assert pattern == path
  end

  test "pattern without extension doesn't match path with extension" do
    path    = Path.new('/foo/bar.xml')
    pattern = Pattern.new('/:foo/:bar')

    assert pattern != path
  end

  test "pattern with static extension doesn't match path without extension" do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/:foo/:bar.xml')

    assert pattern != path
  end

  test "pattern with variable extension doesn't match path without extension" do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/:foo/:bar.:type')

    assert pattern != path
  end

  test "doesn't ignore dots in path parts" do
    path    = Path.new('/foo/bar.baz/abc')
    pattern = Pattern.new('/:a/:b/:c')

    assert pattern == path
    pattern.variables.should be(%w( foo bar.baz abc ))
  end

  test "doesn't get confused with extension when path contains other dots" do
    path    = Path.new('/foo/bar.baz/abc.xml')
    pattern = Pattern.new('/:a/:b/:c.:type')

    assert pattern == path
    pattern.variables.should be(%w( foo bar.baz abc xml ))
  end
end
