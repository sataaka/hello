# 基本イメージの設定
FROM openjdk:17-slim as build

# Mavenとアプリケーションのソースコードをコピーするためのディレクトリを作成
WORKDIR /workspace/app

# Maven依存関係のキャッシュを可能にするために、pom.xmlだけを先にコピー
COPY pom.xml /workspace/app/

# アプリケーションのソースコードをコピー
COPY src /workspace/app/src

# プロジェクトをビルドしてjarファイルを生成
RUN mvn package -DskipTests

# ランタイム用の軽量な基本イメージ
FROM openjdk:17-slim

WORKDIR /app

# ビルドステージから生成されたjarファイルをコピー
COPY --from=build /workspace/app/target/*.jar app.jar

# アプリケーションのポートを開放
EXPOSE 8080

# アプリケーションの実行
ENTRYPOINT ["java","-jar","app.jar"]
