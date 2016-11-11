module UnassociatedPicturesHelper
  def add_pictures_from_io(upload_stream)
    upload_stream.map do |uploaded_io|
      File.join(picture_dir, uploaded_io.original_filename.downcase.gsub(%r{['\s\x00\/\\:\*\?\"<>\|]}, '_')).tap do |file|
        File.open(file, 'wb') do |f|
          f.write(uploaded_io.read)
        end
      end
    end
  end

  private

  def picture_dir
    File.join(Rails.root, 'public', 'uploads', 'unassociated_pictures')
  end
end
