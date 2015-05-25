class ResourceBlock
  attr_accessor :resources

  def initialize
    @resources = []
    yield self if block_given?
  end

  def text(title, link, desc)
    @resources << [:text, title, link, desc]
  end

  def video(title, link, desc)
    @resources << [:video, title, link, desc]
  end

  def tutorial(title, link, desc)
    @resources << [:tutorial, title, link, desc]
  end

  def to_partial_path
    "resource/block"
  end
end
