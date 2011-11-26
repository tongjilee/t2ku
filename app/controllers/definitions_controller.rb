# -*- encoding : utf-8 -*-
class DefinitionsController < InheritedResources::Base
  layout 'dtp'
  before_filter{
    @objects = Definition.all
  }
end
