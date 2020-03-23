class PagesController < ApplicationController
  def home
    @main_sliders = OpItem.where(category: "main_sliders")
  end

  def dev_login
    raise "what the!" unless Rails.env.development? || Rails.env.staging?
    sign_in(:user, User.find(params[:id]))
    redirect_to :root
  end

  def reset_password_instructions
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
