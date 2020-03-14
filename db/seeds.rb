camp = Category.create(name:"キャンプ")
mens = Category.create(name:"メンズ")

camp_tent = camp.children.create(name:"テント")
camp_bomfire = camp.children.create(:name=>"焚火")
camp_tent.children.create([{name:"1~2人用"}, {name:"3~4人用"},{name:"5~6人用"}])
camp_bomfire.children.create([{:name=>"Sサイズ"}, {:name=>"Mサイズ"}, {:name=>"Lサイズ"}])

mens_bottoms = mens.children.create(name:"ボトムス")
mens_jacket = mens.children.create(:name=>"ジャケット/アウター")
mens_bottoms.children.create([{name:"ワイドパンツ"}, {name:"スキニー"},{name:"半パン"},{name:"デニム"}])
mens_jacket.children.create([{name:"ダウン"}, {name:"コート"},{name:"ジャケット"},{name:"フリース"}])
  


























#レディースブロック

#レディースの子カテゴリー配列
# lady_child_array = ['トップス','ジャケット/アウター']
#レディースの孫カテゴリー配列
# lady_grandchild_array = [['すべて','Tシャツ/カットソー(半袖/袖なし)','Tシャツ/カットソー(七分/長袖)','シャツ','ポロシャツ','その他'], ['すべて','テーラードジャケット','ノーカラージャケット','Gジャン/デニムジャケット','レザージャケット','ダウンジャケット','その他']]

# parent = Category.create(name: 'レディース')
# lady_child_array.each_with_index do |child, i|
#  child = parent.children.create(name: child)
#  lady_grandchild_array[i].each do |grandchild|
#    child.children.create(name: grandchild)
#  end
# end

#メンズブロック

#メンズの子カテゴリー配列
# mens_child_array = ['トップス','ジャケット/アウター']
#メンズの孫カテゴリー配列
# mens_grandchild_array = [['すべて','Tシャツ/カットソー(半袖/袖なし)','Tシャツ/カットソー(七分/長袖)','シャツ','ポロシャツ','その他'], ['すべて','テーラードジャケット','ノーカラージャケット','Gジャン/デニムジャケット','レザージャケット','ダウンジャケット','その他']]

# parent = Category.create(name: 'メンズ')
# mens_child_array.each.each_with_index do |child, i|
#  child = parent.children.create(name: child)
#  mens_grandchild_array[i].each do |grandchild|
#    child.children.create(name: grandchild)
#  end
# end











#元々のやつ
#親要素
#lady = Category.create(:name=>"メンズ")

#子要素
#lady_tops = lady.children.create(:name=>"トップス")
#lady_jacket = lady.children.create(:name=>"ジャケット/アウター")

#孫要素（childrenと記述することで直前の変数の子要素として扱うことができる）
#lady_tops.children.create([{:name=>"Tシャツ/カットソー(半袖/袖なし)"}, {:name=>"Tシャツ/カットソー(七分/長袖)"},{:name=>"その他"}])
#lady_jacket.children.create([{:name=>"テーラードジャケット"}, {:name=>"ノーカラージャケット"}, {:name=>"Gジャン/デニムジャケット"},{:name=>"その他"}])
