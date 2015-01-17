Rails.application.routes.draw do
  get 'tests/offsite_with_path' => 'tests#offsite_with_path', as: 'offsite_with_path'
  get 'tests/offsite' => 'tests#offsite', as: 'offsite'
  get 'tests/blank' => 'tests#blank', as: 'blank'
  get 'tests/return_with_path' => 'tests#return_with_path', as: 'return_with_path'
  get 'tests/save' => 'tests#save', as: 'save'
  post 'tests/redirect_with_options' => 'tests#redirect_with_options', as: 'redirect_with_options'
  get 'tests/clear_and_save' => 'tests#clear_and_save', as: 'clear_and_save'
  put 'tests/return_with_options' => 'tests#return_with_options', as: 'return_with_options'
  delete 'tests/clear_and_redirect' => 'tests#clear_and_redirect', as: 'clear_and_redirect'

  root 'tests#blank'
end
