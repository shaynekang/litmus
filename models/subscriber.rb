# encoding: UTF-8

class Subscriber
  include DataMapper::Resource
  include EMailable

  property :id, Serial, unique: true
  property :email, String, :required => true, :unique => true,
    :format   => :email_address,
    :messages => {
      :presence  => '이메일 주소를 입력해주세요.',
      :is_unique => '같은 이메일이 이미 등록되어 있습니다.',
      :format    => "올바른 이메일 주소를 입력해주세요."
    }

  def self.subscribe
    feed = Feedzirra::Feed.fetch_and_parse("http://blog.ohmynews.com/litmus/rss")
    self.all.each do |subscriber|
      feed.entries.each do |entry|
        subscriber.send_mail({
          title: "팀블로그 리트머스 최신글: #{entry.title}",
          summary: Nokogiri::HTML(entry.summary).xpath("//text()").to_s
        })
      end
    end
  end

  def errors?
    errors.any?
  end

  def success_message
    "이메일이 등록되었습니다!"
  end

  def error_message
    errors.full_messages.first
  end
end