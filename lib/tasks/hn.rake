require 'http'

namespace :hn do
  BASE_URL = "https://hacker-news.firebaseio.com/v0"
  TOP_STORIES_URL = BASE_URL + "/topstories.json"

  def story_url(id)
    BASE_URL + "/item/#{id}.json"
  end

  def text_only_url(id)
    "https://news.ycombinator.com/item?id=#{id}"
  end

  def parse(response)
    JSON.parse(response.to_s, symbolize_names: true)
  end

  desc "Download updates from HackerNews"
  task :update => :environment do
    #1. Get the JSON IDs payload from HN
    puts "Getting Top Stories"
    response = HTTP.get(TOP_STORIES_URL)
    hn_ids = parse(response)

    #2. Archive any existing stories whose id isn't in the data
    to_archive = Story.where.not(hn_id: hn_ids)
    puts "Archiving #{to_archive.count} Stories"
    to_archive.update_all(archived: true)

    #3. Pass through the HNIDS and create any stories that aren't already created
    hn_ids.each do |hn_id|
      unless Story.find_by_hn_id(hn_id)
        puts "Fetching #{hn_id}"
        data = parse HTTP.get(story_url(hn_id))

        # Some posts on HN are text only
        url = data[:url] || text_only_url(data[:id])

        Story.create({
          hn_id: data[:id],
          title: data[:title],
          url: url,
          by: data[:by],
          created_at: Time.at(data[:time]),
        })
      end
    end
  end
end
