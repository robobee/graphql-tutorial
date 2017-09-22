require 'test_helper'

class Resolvers::CreateLinkTest < ActiveSupport::TestCase
  def perform(args = {}, ctx = {})
    Resolvers::CreateLink.new.call(nil, args, ctx)
  end

  test 'creating new link' do
    user = ::Resolvers::CreateUser.new.call(nil, {
      name: 'Test User',
      authProvider: {
        email: {
          email: 'email@example.com',
          password: '[omitted]'
        }
      }
    }, nil)
    link = perform(
      {
        url: 'http://example.com',
        description: 'description'
      },
      current_user: user
    )

    assert link.persisted?
    assert_equal link.description, 'description'
    assert_equal link.url, 'http://example.com'
  end
end
