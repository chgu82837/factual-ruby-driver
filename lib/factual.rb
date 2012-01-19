require 'oauth'
require 'factual/api'
require 'factual/query/table'
require 'factual/query/resolve'
require 'factual/query/crosswalk'

class Factual
  def initialize(key, secret)
    @api = Factual::API.new(generate_token(key, secret))
  end

  def table(table_id_or_alias)
    Factual::Query::Table.new(@api, "t/#{table_id_or_alias}")
  end

  def crosswalk(factual_id)
    Factual::Query::Crosswalk.new(@api, :factual_id => factual_id)
  end

  def resolve(values)
    Factual::Query::Resolve.new(@api, :values => values)
  end

  private

  def generate_token(key, secret)
    OAuth::AccessToken.new(OAuth::Consumer.new(key, secret))
  end
end
