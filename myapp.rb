# myapp.rb
require 'rubygems'
require 'bundler'


Bundler.require

set :database, {adapter: "sqlite3", database: "contacts.sqlite3"}

class Contact < ActiveRecord::Base
  validates_presence_of :name
end

get '/' do                  # ホーム画面を表示
  @now = Time.now           # index.erbに渡す @を付ける
  @contacts = Contact.all   # @contactsに配列としてDB内のレコードを追加
  erb :index
end

get '/contact_new' do       # 新規連絡先作成画面を表示
  @contact = Contact.new    # 
  erb :contact_form
end

post '/contacts' do
  puts '###送信されたデータ###'
  p params

  name = params[:name]

  # DBに保存
  @contact = Contact.new({name: name})
  if @contact.save
    # true
    redirect '/'
  else
    # false
    erb :contact_form
  end

end
