
user1 = User.create!(
  name: '岸本',
  email: 'kishimoto@aaa',
  password: 'kishimoto',
  introduction: 'だってばよ'
)

# 本の投稿データの作成
book1 = user1.books.create!(
  title: 'NARUTO',
  body: '螺旋丸',
  date: Date.new(2021, 12, 1),
  star: 4,
  tag: 'ジャンプ'
)

book2 = user1.books.create!(
  title: 'BORUTO',
  body: '楔',
  date: Date.new(2023, 2, 1),
  star: 4,
  tag: 'ジャンプ'
)



user2 = User.create!(
  name: '鳥山',
  email: 'toriyamao@aaa',
  password: 'toriyama',
  introduction: 'かめはめ波'
)

book3 = user2.books.create!(
  title: 'ドラゴンボール',
  body: '身勝手の極意',
  date: Date.new(1990, 12, 1),
  star: 5,
  tag: 'ジャンプ'
)

book4 = user2.books.create!(
  title: 'Dr.スランプ',
  body: 'ｷｰｰｰｰｰｰﾝ',
  date: Date.new(1988, 2, 1),
  star: 4,
  tag: 'ジャンプ'
)


user = User.find_or_create_by(
  name: '奈須',
  email: 'typemoon@aaa',
  password: 'typemoon',
  introduction: 'この人でなし！'
)

# 本の作成
book5 = user.books.create!(
  title: '月姫',
  body: '真祖の姫君',
  date: Date.new(1990, 12, 1),
  star: 5,
  tag: '同人'
)

book6 = user.books.create!(
  title: 'Fate/Zero',
  body: 'ヒーローになりたかった',
  date: Date.new(1988, 2, 1),
  star: 4,
  tag: '小説'
)


user3 = User.create!(
  name: '奈須',
  email: 'typemoon@aaa',
  password: 'typemoon',
  introduction: 'この人でなし！'
)