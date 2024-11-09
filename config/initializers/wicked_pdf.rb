# WickedPDF Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `render :pdf` call.
#
# To learn more, check out the README:
#
# https://github.com/mileszs/wicked_pdf/blob/master/README.md

WickedPdf.configure do |config|
  if Rails.env.production?
    # Path to where the actual gem binary is extracted:
    #config.exe_path = "#{ENV['GEM_HOME']}/gems/wkhtmltopdf-binary-#{Gem.loaded_specs['wkhtmltopdf-binary'].version}/bin/wkhtmltopdf_macos_cocoa"

    # Or a copied binary in the /bin/ path:
    config.exe_path = Rails.root.join('bin/wkhtmltopdf').to_s
  end
end
