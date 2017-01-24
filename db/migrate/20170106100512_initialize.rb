class Initialize < ActiveRecord::Migration[5.0]

  def change

    create_table :users, comment: 'ユーザーマスタ' do |t|
      t.string :nick_name, null: false, default: '', comment: 'ニックネーム'

      ## Database authenticatable
      t.string :email,              null: false, default: '', comment: 'メールアドレス'
      t.string :encrypted_password, null: false, default: '', comment: 'パスワード(ハッシュ値)'

      ## Recoverable
      t.string   :reset_password_token,   comment: 'パスワードリセットトークン'
      t.datetime :reset_password_sent_at, comment: 'パスワードリセット要求日時'

      ## Rememberable
      t.datetime :remember_created_at, comment: '次回自動指定でのログイン日時'

      ## Trackable
      t.integer  :sign_in_count,      default: 0, null: false, comment: 'ログイン回数'
      t.datetime :current_sign_in_at, comment: '今回ログイン日時'
      t.datetime :last_sign_in_at,    comment: '前回ログイン日時'
      t.string   :current_sign_in_ip, comment: '今回アクセス元IP'
      t.string   :last_sign_in_ip,    comment: '前回アクセス元IP'

      ## Confirmable
      t.string   :confirmation_token,   comment: '登録確認トークン'
      t.datetime :confirmed_at,         comment: '登録確認済み日時'
      t.datetime :confirmation_sent_at, comment: '登録確認要求日時'
      t.string   :unconfirmed_email,    comment: '未確認メールアドレス' # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts,  default: 0, null: false, comment: '認証失敗回数' # Only if lock strategy is :failed_attempts
      t.string   :unlock_token,     comment: 'アカウントロック解除トークン' # Only if unlock strategy is :email or :both
      t.datetime :locked_at,        comment: 'アカウントロック日時'

      ## t.attachment :image
      t.string   :image_file_name,    comment: '画像ファイル名'
      t.string   :image_content_type, comment: '画像MIMEタイプ'
      t.integer  :image_file_size,    comment: '画像ファイルサイズ'
      t.datetime :image_updated_at,   comment: '画像更新日時'

      t.text     :bio,    comment: '自己紹介'
      t.text     :note,   comment: 'メモ'

      t.datetime :created_at, null: false, comment: '作成日時'
      t.datetime :updated_at, null: false, comment: '更新日時'
    end
    add_index :users, :email
    add_index :users, :reset_password_token,        unique: true
    add_index :users, :confirmation_token,          unique: true
    add_index :users, :unlock_token,                unique: true
    add_index :users, :created_at
    add_index :users, :updated_at

    create_table :roles, comment: 'ロールマスタ' do |t|
      t.string    :code,        null: false, comment: 'コード'
      t.string    :name,        null: false, default: '', comment: '名称'
      t.text      :policy,      null: false, default: '', comment: 'ポリシー'
      t.text      :description, null: false, default: '', comment: '説明'
      t.integer   :sort,        comment: '並び順'
      t.datetime :created_at,   null: false, comment: '作成日時'
      t.datetime :updated_at,   null: false, comment: '更新日時'
    end
    add_index :roles, :code, unique: true
    add_index :roles, :created_at
    add_index :roles, :updated_at

    create_table :users_roles, comment: 'ユーザー：ロール' do |t|
      t.integer :user_id, null: false, comment: 'ユーザーID'
      t.integer :role_id, null: false, comment: 'ロールID'
    end
    add_index :users_roles, [:user_id, :role_id], unique: true
    add_foreign_key :users_roles, :users
    add_foreign_key :users_roles, :roles

    create_table :sessions, comment: 'セッションデータ' do |t|
      t.string    :session_id,          comment: 'セッションID', null: false
      t.text      :data,                comment: 'データ'
      t.datetime  :created_at,          comment: '作成日時', null: false
      t.datetime  :updated_at,          comment: '更新日時', null: false
    end
    add_index :sessions, :session_id, unique: true
    add_index :sessions, :created_at
    add_index :sessions, :updated_at

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
    add_foreign_key :attendees, :lounges

    create_table :channel_attendees, comment: 'チャンネル参加者' do |t|
      t.string    :uuid,                comment: 'UUID', null: false
      t.integer   :channel_id,          comment: 'チャンネルID', null: false
      t.integer   :attendee_id,         comment: '参加者ID', null: false
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
