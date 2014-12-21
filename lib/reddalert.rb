require "reddalert/version"
require "httparty"
require "pstore"
#!/usr/bin/env ruby

module Reddalert
  def have_stored_date?
    store = PStore.new("data.pstore")
    !store.transaction { store[:newest_post_date] }.nil?
  end

  def newest_post_date_after_stored_date?(newest_post_date)
    store = PStore.new("data.pstore")
    newest_post_date > store.transaction { store[:newest_post_date] }
  end

  def store_new_date_and_title(date, title)
    store = PStore.new("data.pstore")
    store.transaction do
      store[:newest_post_date] = date
      store[:newest_post_title] = title
      pp store[:newest_post_date]
    end
  end

  url = "http://www.reddit.com/r/forhire/new.json?limit=100"
  response = HTTParty.get(url)
  body = response.body
  parsed_body = JSON.parse(body)

  `say "HI COLIN"`
  newest_post = parsed_body["data"]["children"].first
  newest_post_date_utc = newest_post["data"]["created_utc"]
  newest_post_date = DateTime.strptime("#{newest_post_date_utc}", '%s').to_time
  newest_post_title = newest_post["data"]["title"]
  pp newest_post["data"]["link_flair_text"]
  if newest_post["data"]["link_flair_text"] == "Hiring"
    if have_stored_date? && newest_post_date_after_stored_date?(newest_post_date)
      pp "WE FOUND A NEW POST!"
      `say "WE FOUND A NEW POST!"`
    elsif !have_stored_date?
      pp "NO DATE CURRENTLY STORED"
      `say "NO DATE CURRENTLY STORED"`
    else
      pp "NO NEW POST FOUND!"
      # `say "NO NEW POST FOUND!"`
    end
    store_new_date_and_title(newest_post_date, newest_post_title)
  end
end
