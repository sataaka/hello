# 基本イメージの設定
FROM openjdk:17-slim as build

# Mavenとアプリケーションのソースコードをコピーするためのディレクトリを作成
WORKDIR /workspace/app

# Maven依存関係のキャッシュを可能にするために、pom.xmlだけを先にコピー
COPY pom.xml /workspace/app/

# Maven依存関係のダウンロード
RUN mvn dependency:go-offline -B

# アプリケーションのソースコードをコピー
COPY src /workspace/app/src

# プロジェクトをビルドしてjarファイルを生成
RUN mvn package -DskipTests

# ランタイム用の軽量な基本イメージ
FROM openjdk:17-slim

# Mavenのインストール
RUN apt-get update && apt-get install -y maven

WORKDIR /app

# ビルドステージから生成されたjarファイルをコピー
COPY --from=build /workspace/app/target/*.jar app.jar

# アプリケーションの実行
ENTRYPOINT ["java","-jar","app.jar"]
