require 'test/test_helper'

## SimpleEngine
context do
  include SimpleRouter::Engines::SimpleEngine

  # matches static paths 
  test do
    Base.match('/',    ['/', '/foo']).first.must == '/'
    Base.match('/foo', ['/', '/foo']).first.must == '/foo'
    Base.match('/bar', ['/', '/foo']).first.must == nil
  end

  # matches variable paths 
  test do
    path, vars = Base.match('/80/07', ['/foo', '/:year/:month'])
    path.must == '/:year/:month'
    vars.must == ['80','07']
  end

  # matches hybrid paths 
  test do
    path, vars = Base.match('/archives/80/07', ['/foo', '/archives/:year/:month'])
    path.must == '/archives/:year/:month'
    vars.must == ['80','07']
  end

  # ignores leading slash in path 
  test do
    path, vars = Base.match('archives/80/07', ['/foo', '/archives/:year/:month'])
    path.must == '/archives/:year/:month'
    vars.must == ['80','07']
  end

  # no matches 
  test do
    path, vars = Base.match('/80/07/01', ['/foo', '/:year/:month'])
    path.must == nil
    vars.must == []
  end

  # treats extension as pattern part 
  test do
    path, vars = Base.match('/a/b.xml', ['/:foo/:bar', '/:foo/:bar.:type'])
    path.must == '/:foo/:bar.:type'
    vars.must == ['a','b','xml']
  end
end

## Pattern
context do
  include SimpleRouter::Engines::SimpleEngine

  # static pattern matches a path 
  test do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/foo/bar')

    assert { pattern == path }
  end

  # variable pattern matches a path 
  test do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/:foo/:bar')

    assert { pattern == path }
  end

  # pattern variables 
  test do
    path    = Path.new('/foo/bar/baz')
    pattern = Pattern.new('/:a/:b/:c')

    assert { pattern == path }
    pattern.vars.must == %w( foo bar baz )
  end

  # pattern variables with extension 
  test do
    path    = Path.new('/foo/bar/baz.xml')
    pattern = Pattern.new('/:a/:b/:c.:type')

    assert { pattern == path }
    pattern.vars.must == %w( foo bar baz xml )
  end

  # variable pattern matches a path with static extension 
  test do
    path    = Path.new('/foo/bar.xml')
    pattern = Pattern.new('/:foo/:bar.xml')

    assert { pattern == path }
  end

  # variable pattern matches a path with variable extension 
  test do
    path    = Path.new('/foo/bar.xml')
    pattern = Pattern.new('/:foo/:bar.:type')

    assert { pattern == path }
  end

  # pattern without extension doesn't match path with extension 
  test do
    path    = Path.new('/foo/bar.xml')
    pattern = Pattern.new('/:foo/:bar')

    assert { pattern != path }
  end

  # pattern with static extension doesn't match path without extension 
  test do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/:foo/:bar.xml')

    assert { pattern != path }
  end

  # pattern with variable extension doesn't match path without extension 
  test do
    path    = Path.new('/foo/bar')
    pattern = Pattern.new('/:foo/:bar.:type')

    assert { pattern != path }
  end

  # doesn't ignore dots in path parts 
  test do
    path    = Path.new('/foo/bar.baz/abc')
    pattern = Pattern.new('/:a/:b/:c')

    assert { pattern == path }
    pattern.variables.must == %w( foo bar.baz abc )
  end

  # doesn't get confused with extension when path contains other dots 
  test do
    path    = Path.new('/foo/bar.baz/abc.xml')
    pattern = Pattern.new('/:a/:b/:c.:type')

    assert { pattern == path }
    pattern.variables.must == %w( foo bar.baz abc xml )
  end
end
