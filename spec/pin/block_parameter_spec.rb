describe Solargraph::Pin::BlockParameter do
  # @todo Refactor
  it "detects block parameter return types from @yieldparam tags" do
    # api_map = Solargraph::ApiMap.new
    # source = Solargraph::Source.load_string(%(
    #   # @yieldparam [Array]
    #   def yielder
    #   end

    #   yielder do |things|
    #     things
    #   end
    # ), 'file.rb')
    # api_map.virtualize source
    # fragment = source.fragment_at(6, 9)
    # pins = fragment.define(api_map)
    # expect(pins.first.return_complex_type.namespace).to eq('Array')
  end

  # @todo Refactor
  it "detects block parameter return types from core methods" do
    # api_map = Solargraph::ApiMap.new
    # source = Solargraph::Source.load_string(%(
    #   String.new.split.each do |str|
    #     str
    #   end
    # ), 'file.rb')
    # api_map.virtualize source
    # fragment = source.fragment_at(2, 9)
    # pins = fragment.define(api_map)
    # expect(pins.first.return_complex_type.namespace).to eq('String')
  end

  # @todo Refactor
  it "prioritizes param type tags" do
    # api_map = Solargraph::ApiMap.new
    # source = Solargraph::Source.load_string(%(
    #   require 'set'

    #   # @yieldparam [Array]
    #   def yielder
    #   end

    #   # @param things [Set]
    #   yielder do |things|
    #     things
    #   end
    # ), 'file.rb')
    # api_map.virtualize source
    # fragment = source.fragment_at(9, 9)
    # pins = fragment.define(api_map)
    # expect(pins.first.return_complex_type.namespace).to eq('Set')
  end

  it "is a kind of block_parameter/variable" do
    source = Solargraph::Source.new(%(
      foo.bar do |baz|
      end
    ))
    map = Solargraph::SourceMap.map(source)
    block = map.pins.select{|p| p.kind == Solargraph::Pin::BLOCK}.first
    param = block.parameters.first
    expect(param.kind).to eq(Solargraph::Pin::BLOCK_PARAMETER)
    expect(param.completion_item_kind).to eq(Solargraph::LanguageServer::CompletionItemKinds::VARIABLE)
    expect(param.symbol_kind).to eq(Solargraph::LanguageServer::SymbolKinds::VARIABLE)
  end
end
