class Task < ApplicationRecord
  #Taskはどれかのuserに属する
  #User と task の一対多を表現している
  belongs_to :user
  
  #contentは必ず文字が存在しなければならず、最大255文字しか書けない。
  #statusは必ず文字が存在しなければならず、最大10文字しか書けない。
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10 }
end
