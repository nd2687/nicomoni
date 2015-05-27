module FeaturesSpecHelper
  def login(user, password="password")
    visit new_session_path
    within('form') do
      fill_in 'nickname', with: user.nickname
      fill_in 'password', with: password
      click_button 'ログイン'
    end
  end

  def debug
    save_and_open_page
  end
end
