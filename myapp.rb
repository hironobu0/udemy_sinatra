# myapp.rb
require 'rubygems'
require 'bundler'


Bundler.require

set :database, {adapter: "sqlite3", database: "contacts.sqlite3"}
enable :sessions

class Contact < ActiveRecord::Base   # DBにアクセスするクラス？
  validates_presence_of :name
  validates_presence_of :email
end

get '/' do                    # ホーム画面を表示
  @now      = Time.now        # index.erbに渡す @を付ける
  @contacts = Contact.all     # @contactsに配列としてDB内のレコードを追加
  @message  = session.delete :message
  erb :index
end

get '/contact_new' do         # 新規連絡先作成画面を表示
  @contact = Contact.new      # 新しくレコードを作成
  erb :contact_form
end

post '/contacts' do           # viewのcontact_formから送信されてくる
  puts '###送信されたデータ###'
  p params                    # paramsの中身を表示

  disp_name = params[:input_name]  # viewでフォームからPOST送信された<input name = "name">の情報を受け取る
                                # フォームの内容が:input_nameの中身に入る
  # DBに保存
  @contact = Contact.new( { name: disp_name, email: params[:input_email] } ) # nameカラムにnamingのデータを保存
                                            # {name: disp_name}は{:name => disp_name}と同一
  if @contact.save                          # ActiveRecordのsaveメソッド？
    # true
    session[:message] = "#{disp_name}さんを作成しました"
    redirect '/'
  else
    # false
    erb :contact_form
  end

end
