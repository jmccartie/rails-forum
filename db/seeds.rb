Forum.destroy_all
forum = FactoryGirl.create(:forum)

puts "Creating forums..."
10.times do
  forum = FactoryGirl.create(:forum)
  FactoryGirl.create(:topic, forum_id: forum.id)
end

first_forum = Forum.first
puts "Creating topics.."
10.times do
  topic = FactoryGirl.create(:topic, forum_id: first_forum.id)
  FactoryGirl.create(:post, topic_id: topic.id)
end

first_topic = Topic.first
puts "Creating posts..."
50.times do
  post = FactoryGirl.create(:post, topic_id: first_topic.id)
  print "."
end


puts "==> Done!"