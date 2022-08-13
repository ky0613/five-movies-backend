require "open-uri"

class CreateImage

  def initialize(images, uuid)
    @images = images
    @uuid = uuid
  end

  def create_image
    tmp_images = []

    @images.each do |image_path|
      #　ファイル名をurlから取得
      filename = File.basename(image_path, ".*")

      # ファイルをバイナリ形式に変換
      open("./tmp/#{filename}", "w+b") do |output|
        URI.open(image_path) do |data|
          output.puts(data.read)

          # 作成したバイナリファイルを配列に格納
          tmp_images << output.path
        end
      end
    end

    # モンタージュ画像の作成
    MiniMagick::Tool::Montage.new do |montage|
      tmp_images.each { |image| montage << image }
      montage.geometry "100%"
      montage.tile "5x1"

      montage << "./tmp/#{@uuid}.jpg"
    end

    tmp_images.each do |image|
      File.delete(image)
    end

    image_path = "./tmp/#{@uuid}.jpg"
  end
end
