class User < ApplicationRecord
  #保存前にemailを全て小文字に
  before_save { self.email.downcase! }
  
  #nameは必ず文字が存在しなければならず、最大50文字しか書けない。
  #emailは必ず文字が存在しなければならず、最大255文字しか書けない。
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    #記号の羅列がメールアドレスの正しい形式となる
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #uniqueness:重複不可のバリデーション
                    #case_sensitive:falseは、大文字と小文字を区別しない（taro@もTaro@も同じアドレス扱い)
                    uniqueness: { case_sensitive: false }
  
  #dbのmigrateでpassword_digestカラムを用意し、モデルファイルにhas_secure_passwordを記述すれば、
  #ログイン認証のための準備を自動で用意してくれる
  has_secure_password
  
  #Userからtaskを見た時、複数存在する場合、has_many :tasksと明示しておく
  has_many :tasks
end
