class Test
  def foo
    puts 'foo'
    [1,2,3].each do |el|
      puts el
    end
  end


  def bar
    puts 'bar'
  end

  def baz
    puts 'baz'
  end

  def foobarbaz
    foo
    bar
    baz
  end
end
