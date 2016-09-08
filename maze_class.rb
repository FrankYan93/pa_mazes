require "matrix"

class Maze
  def initialize(n,m)
    @n=n-1
    @m=m-1
    @maze=[]
    @a=Vector[-1,0]#left
    @s=Vector[0,1]#down
    @d=Vector[1,0]#right
    @w=Vector[0,-1]#up
    @trace=[]
  end

  def load
    for i in 0..@n
      @maze<<[]
      for j in 0..@m
        @maze[i]<< 0
      end
    end
  end

  def redesign
    for i in 0..@n
      for j in 0..@m
        @maze[i][j] = rand(2)
      end
    end
  end

  def display(testFile)
    line='1'*(@n+3)
    testFile.puts line
    for j in 0..@m
      testFile.print '1'
      for i in 0..@n
        testFile.print(@maze[i][j])
      end
      testFile.print '1'
      testFile.puts ''
    end
    testFile.puts line
  end

  attr_accessor:maze
  attr_accessor:a
  attr_accessor:s
  attr_accessor:d
  attr_accessor:w
  attr_accessor:n
  attr_accessor:m

  def solve(begX, begY, endX, endY)#recursion
    return false if ((begX>@n)||(begX<0)||(begY>@m)||(begY<0))
    return false if (@maze[begX][begY]>0||@maze[endX][endY]>0)
    @trace<<[begX,begY]
    return true if ((begX==endX)&&(begY=endY))

    unless @trace.include?([begX+@a[0], begY+@a[1]])
      return true if solve(begX+@a[0], begY+@a[1], endX, endY)
    end
    unless @trace.include?([begX+@s[0], begY+@s[1]])
      return true if solve(begX+@s[0], begY+@s[1], endX, endY)
    end
    unless @trace.include?([begX+@d[0], begY+@d[1]])
      return true if solve(begX+@d[0], begY+@d[1], endX, endY)
    end
    unless @trace.include?([begX+@w[0], begY+@w[1]])
      return true if solve(begX+@w[0], begY+@w[1], endX, endY)
    end
    @trace.pop
    return false
  end

  def trace(begX, begY, endX, endY,testFile)
    @trace=[]
    solve(begX, begY, endX, endY)
    lastIndex=@trace.length()-1;
    return "Maze#trace:No way out!" if lastIndex<0
    for i in (0...lastIndex)
      testFile.print @trace[i]
      testFile.print "->"
    end
    testFile.print @trace[lastIndex];
    return "Maze#trace:This is one of the ways to go!"
  end
end