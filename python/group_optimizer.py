import os
import pandas as pd
from sklearn.cluster import KMeans

# UUID環境変数から読み取る（Rails側で指定されている）
uuid = os.environ.get("UUID")
if not uuid:
    raise ValueError("UUIDが設定されていません。環境変数 UUID を指定してください。")

# ファイルパス（Dockerコンテナ内のボリューム共有パス）
students_path = f"/app/tmp/students_{uuid}.csv"
grouped_path = f"/app/tmp/grouped_students_{uuid}.csv"

# CSV読み込み
df = pd.read_csv(students_path)

# 特徴量抽出（能力値のみ使用）
X = df[["athletic_ability", "leadership", "cooperation", "science", "humanities"]]

# グループ数（固定値だが、将来は引数や環境変数で変更可）
group_count = 3

# KMeansクラスタリング実行
kmeans = KMeans(n_clusters=group_count, random_state=42)
df["group_number"] = kmeans.fit_predict(X)

# グループ番号付きのCSVとして保存
df[["id", "group_number"]].to_csv(grouped_path, index=False)

print(f"✅ grouped_students_{uuid}.csv を出力しました")