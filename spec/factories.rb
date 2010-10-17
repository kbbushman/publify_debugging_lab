Factory.sequence :name do |n|
  "name_#{n}"
end

Factory.sequence :user do |n|
  "user#{n}"
end

Factory.sequence :guid do |n|
  "deadbeef#{n}"
end

Factory.sequence :label do |n|
  "lab_#{n}"
end

Factory.sequence :file_name do |f|
  "file_name_#{f}"
end

Factory.sequence :category do |n|
  "category_#{n}"
end

Factory.define :user do |u|
  u.login { Factory.next(:user) }
  u.email { Factory.next(:user) }
  u.notify_via_email false
  u.notify_on_new_articles false
  u.notify_watch_my_articles false
  u.notify_on_comments false
  u.password 'top-secret'
end

Factory.define :article do |a|
  a.title 'A big article'
  a.body 'A content with several data'
  a.extended 'extended content for fun'
  a.guid { Factory.next(:guid) }
  a.permalink 'a-big-article'
  a.published_at Time.now
  a.user { |u| u.association(:user) }
end

Factory.define :utf8article, :parent => :article do |u|
  u.title 'ルビー'
  u.permalink 'ルビー'
end

Factory.define :second_article, :parent => :article do |a|
  a.title 'Another big article'
  a.published_at Time.now - 2.seconds
end

Factory.define :article_with_accent_in_html, :parent => :article do |a|
  a.title 'article with accent'
  a.body '&eacute;coute The future is cool!'
  a.permalink 'article-with-accent'
  a.published_at Time.now - 2.seconds
end

Factory.define :blog do |b|
  b.base_url 'http://myblog.net'
  b.blog_name 'test blog'
end

Factory.define :profile_admin, :class => :profile do |l|
  l.label {Factory.next(:label)}
  l.nicename 'Typo administrator'
  l.modules [:dashboard, :write, :content, :feedback, :themes, :sidebar, :users, :settings, :profile]
end

Factory.define :profile_publisher, :class => :profile do |l|
  l.label 'published'
  l.nicename 'Blog publisher'
  l.modules [:dashboard, :write, :content, :feedback, :profile]
end
Factory.define :profile_contributor, :class => :profile do |l|
  l.label 'contributor'
  l.nicename 'Contributor'
  l.modules [:dashboard, :profile]
end

Factory.define :category do |c|
  c.name {Factory.next(:category)}
  c.permalink {Factory.next(:category)}
  c.position 1
end

Factory.define :tag do |tag|
  tag.name {Factory.next(:name)}
  tag.display_name {Factory.next(:name)}
end

Factory.define :resource do |r|
  r.filename {Factory.next(:file_name)}
  r.mime 'image/jpeg'
  r.size 110
end

Factory.define :redirect do |r|
  r.from_path 'foo/bar'
  r.to_path '/someplace/else'
end

Factory.define :comment do |c|
  c.published true
  c.article {|a| a.association(:article)}
  c.author 'Bob Foo'
  c.url 'http://fakeurl.com'
  c.body 'Test <a href="http://fakeurl.co.uk">body</a>'
  c.created_at '2005-01-01 02:00:00'
  c.updated_at '2005-01-01 02:00:00'
  c.published_at '2005-01-01 02:00:00'
  c.guid '12313123123123123'
  c.state 'ham'
end

Factory.define :spam_comment, :parent => :comment do |c|
  c.state 'spam'
end

Factory.define :page do |p|
  p.name 'page_one'
  p.title 'Page One Title'
  p.body 'ho ho ho'
  p.created_at '2005-05-05 01:00:01'
  p.published_at '2005-05-05 01:00:01'
  p.updated_at '2005-05-05 01:00:01'
  p.user {|u| u.association(:user)}
  p.published true
  p.state 'published'
end
