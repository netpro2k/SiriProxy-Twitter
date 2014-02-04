require 'twitter'

class SiriProxy::Plugin::Twitter < SiriProxy::Plugin
  def initialize(config = {})
    @config = config

    ::Twitter.configure do |config|
      config.consumer_key = @config['consumer_key']
      config.consumer_secret = @config['consumer_secret']
      config.oauth_token = @config['oauth_token']
      config.oauth_token_secret = @config['oauth_token_secret']
    end

    @twitterClient = ::Twitter::Client.new
  end

  listen_for /tweet (.+)/i do |tweetText|
    say "Here is your tweet:"

    # send a "Preview" of the Tweet
    object = SiriAddViews.new
    object.make_root(last_ref_id)
    answer = SiriAnswer.new("Tweet", [
      SiriAnswerLine.new('logo', @config['image_url']),
      SiriAnswerLine.new(tweetText)
    ])
    object.views << SiriAnswerSnippet.new([answer])
    send_object object

    if confirm "Ready to send it?"
      say "Posting to twitter..."
      Thread.new {
        begin
          @twitterClient.update(tweetText)
          say "Ok it has been posted."
        rescue Exception
          pp $!
          say "Sorry, I encountered an error: #{$!}"
        ensure
          request_completed
        end
      }
    else
      say "Ok I won't send it."
      request_completed
    end
  end
end
