class Initialize < ActiveRecord::Migration[5.0]
  def change

    create_table :oauth_applications, comment: 'OAuthアプリケーション' do |t|
#      t.integer   :user_id,             comment: 'ユーザーID', null: false
      t.string    :name,                comment: '名称', null: false
      t.string    :uid,                 comment: 'アプリケーションID', null: false
      t.string    :secret,              comment: 'シークレット', null: false
      t.text      :redirect_uri,        comment: 'コールバックURL', null: false
      t.string    :scopes,              comment: 'スコープ', null: false, default: ''
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.datetime  :updated_at,          comment: '更新日時', null: false
    end
    add_index :oauth_applications, :uid, unique: true
#    add_index :oauth_applications, :user_id
#    add_foreign_key :oauth_applications, :users

    create_table :oauth_access_grants, comment: 'OAuthアクセスグラント' do |t|
      t.integer   :resource_owner_id,   comment: 'リソース所有者ID', null: false
      t.integer   :application_id,      comment: 'アプリケーションID', null: false
      t.string    :token,               comment: 'アクセストークン', null: false
      t.integer   :expires_in,          comment: '有効期限', null: false
      t.text      :redirect_uri,        comment: 'コールバックURL', null: false
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.datetime  :revoked_at,          comment: '無効化日時'
      t.string    :scopes,              comment: 'スコープ'
    end
    add_index :oauth_access_grants, :token, unique: true

    create_table :oauth_access_tokens, comment: 'OAuthアクセストークン' do |t|
      t.integer   :resource_owner_id,   comment: 'リソース所有者ID'
      t.integer   :application_id,      comment: 'アプリケーションID'
      t.string    :token,               comment: 'アクセストークン', null: false
      t.string    :refresh_token,       comment: 'リフレッシュトークン'
      t.integer   :expires_in,          comment: '有効期限'
      t.datetime  :revoked_at,          comment: '無効化日時'
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.string    :scopes,              comment: 'スコープ'
    end
    add_index :oauth_access_tokens, :token, unique: true
    add_index :oauth_access_tokens, :resource_owner_id
    add_index :oauth_access_tokens, :refresh_token, unique: true

    create_table :lounges, comment: 'ラウンジ' do |t|
      t.string    :uuid,                comment: 'UUID', null: false
      t.string    :name,                comment: '名称'
      t.text      :description,         comment: '説明'
      t.string    :image_file_name,     comment: '画像ファイル名'
      t.string    :image_content_type,  comment: '画像MIMEタイプ'
      t.integer   :image_file_size,     comment: '画像ファイルサイズ'
      t.datetime  :image_updated_at,    comment: '画像更新日時'
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.datetime  :updated_at,          comment: '更新日時', null: false
    end
    add_index :lounges, :uuid, unique: true
    add_index :lounges, :created_at
    add_foreign_key :lounges, :users

    create_table :channels, comment: 'チャンネル' do |t|
      t.string    :uuid,                comment: 'UUID', null: false
      t.integer   :lounge_id,           comment: 'ラウンジID', null: false
      t.string    :name,                comment: '名称'
      t.text      :description,         comment: '説明'
      t.string    :image_file_name,     comment: '画像ファイル名'
      t.string    :image_content_type,  comment: '画像MIMEタイプ'
      t.integer   :image_file_size,     comment: '画像ファイルサイズ'
      t.datetime  :image_updated_at,    comment: '画像更新日時'
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.datetime  :updated_at,          comment: '更新日時', null: false
    end
    add_index :channels, :uuid, unique: true
    add_index :channels, [:lounge_id, :name], unique: true
    add_index :channels, :created_at
    add_foreign_key :channels, :lounges

    create_table :attendees, comment: 'ラウンジ参加者' do |t|
      t.string    :uuid,                comment: 'UUID', null: false
      t.integer   :lounge_id,           comment: 'ラウンジID', null: false
      t.text      :name,                comment: '表示名'
      t.text      :url,                 comment: 'リンク先'
      t.string    :image_file_name,     comment: '画像ファイル名'
      t.string    :image_content_type,  comment: '画像MIMEタイプ'
      t.integer   :image_file_size,     comment: '画像ファイルサイズ'
      t.datetime  :image_updated_at,    comment: '画像更新日時'
      t.integer   :level,               comment: 'レベル', null: false, default: 0
      t.integer   :status,              comment: '状態(-1:スパイ 0:オフ 1:オン)', null: false, default: 1
      t.string    :remote_ip,           comment: 'IPアドレス'
      t.text      :user_agent,          comment: 'UserAgent'
      t.text      :ext1,                comment: '拡張データ1'
      t.text      :ext2,                comment: '拡張データ2'
      t.text      :ext3,                comment: '拡張データ3'
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.datetime  :updated_at,          comment: '更新日時', null: false
    end
    add_index :attendees, :uuid, unique: true
    add_index :attendees, :lounge_id
    add_foreign_key :attendees, :channels

    create_table :channel_attendees, comment: 'チャンネル参加者' do |t|
      t.string    :uuid,                comment: 'UUID', null: false
      t.integer   :channel_id,          comment: 'チャンネルID', null: false
      t.integer   :attendee_id,         comment: 'ラウンジ参加者ID', null: false
      t.datetime  :created_at,          comment: '作成日時', null: false
    end
    add_index :channel_attendees, :uuid, unique: true
    add_index :channel_attendees, :channel_id
    add_index :channel_attendees, :attendee_id
    add_foreign_key :channel_attendees, :channels
    add_foreign_key :channel_attendees, :attendees

    create_table :messages, comment: 'メッセージ' do |t|
      t.string    :uuid,                comment: 'UUID', null: false
      t.integer   :channel_id,          comment: 'チャンネルID', null: false
      t.integer   :channel_attendee_id, comment: 'チャンネル参加者ID', null: false
      t.text      :body,                comment: '内容'
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.datetime  :updated_at,          comment: '更新日時', null: false
      t.datetime  :deleted_at,          comment: '削除日時', null: false
      t.datetime  :edited_at,           comment: '変更日時', null: false
    end
    add_index :messages, :uuid, unique: true
    add_index :messages, :channel_id
    add_index :messages, :channel_attendee_id
    add_foreign_key :messages, :channels
    add_foreign_key :messages, :channel_attendees

    create_table :message_attendees, comment: 'メッセージ既読' do |t|
      t.integer   :message_id,          comment: 'メッセージID', null: false
      t.integer   :attendee_id,         comment: '参加者ID', null: false
      t.datetime  :created_at,          comment: '作成日時', null: false
    end
    add_index :message_attendees, :message_id
    add_index :message_attendees, :attendee_id
    add_foreign_key :message_attendees, :messages
    add_foreign_key :message_attendees, :attendees

  end
end
