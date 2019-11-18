class PagesController < ApplicationController
  def home
  end

  def pdf
    respond_to do |format|
      format.html
      format.pdf do
        pdf_config
        render pdf: "상담 일지-#{ Time.now.strftime("%m-%d %I%p")}.pdf",
               layout: 'layouts/application.pdf.haml',
               encoding: 'utf8'
      end
    end
  end

  def pdf_config
    WickedPdf.config = {
    }
  end
end
