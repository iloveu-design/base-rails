class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  def facebook
    data = request.env["omniauth.auth"]
    @user = User.find_sns_oauth(data["uid"], 'facebook')
    if @user.present?
      sign_in @user
      redirect_to root_path
    elsif User.find_by(email: data["info"]["email"], provider: nil).present?
      flash[:alert] = '이미 해당 이메일 주소로 가입된 계정이 있습니다'
      redirect_to new_user_session_path
    else
      auth = {
        'provider' => 'facebook',
        'uid' => data["uid"],
        'email' => data["info"]["email"],
        'name' => data["info"]["name"] || "회원 #{rand(10000)}"
      }
      @user = User.set_oauth(auth)
      sign_in @user
      redirect_to edit_user_registration_path
    end
  end

  def naver
    data = request.env["omniauth.auth"]["info"]
    uid = request.env["omniauth.auth"]["uid"]
    @user = User.find_sns_oauth(data["email"], 'naver')
    if @user.present?
      sign_in @user
      redirect_to root_path
    elsif User.find_by(email: data["email"], provider: nil).present?
      flash[:alert] = '이미 해당 이메일 주소로 가입된 계정이 있습니다'
      redirect_to new_user_session_path
    else
      auth = {
        'provider' => 'naver',
        'uid' => uid,
        'email' => data["email"],
        'name' => data["name"] || "회원 #{rand(10000)}"
      }
      @user = User.set_oauth(auth)
      sign_in @user
      redirect_to edit_user_registration_path
    end
  end

  def kakao
    data = request.env["omniauth.auth"]
    @user = User.find_sns_oauth(data["uid"], 'kakao')
    if @user.present?
      sign_in @user
      redirect_to root_path
    else
      auth = {
        'provider' => 'kakao',
        'uid' => data["uid"],
        'name' => data["name"] || "회원 #{rand(10000)}",
        'email' => "kakao_#{data['uid']}@email.com"
      }
      @user = User.set_oauth(auth)
      sign_in @user
      redirect_to edit_user_registration_path
    end
  end
end
