# jump_back

jump_back is a gem that improves redirecting back in rails.

As you have probably experienced, `redirect_to :back` can occassionally cause errors, so it is best to have a plan for what happens when there is no `HTTP_REFERER`. `jump_back` gives you the `redirect_back` method in your `ApplicationController` (and anything that inherits from the `ApplicationController`) that avoids errors and adds some useful functionality. See the Usage section below for details.

Also, sometimes you want to save what a person was doing before you redirected them. Maybe you need them to log in before seeing some content, or maybe there is more than one view that links to an `edit` page and you want to redirect them back to wherever they were after the `update`. `jump_back` adds `save_referer` and `return_to_referer` methods to your `ApplicationController` (and anything that inherits from the `ApplicationController`) to make this functionality easy. See the Usage section below for details.

jump_back is tested in ruby version 1.9.3, 2.0, 2.1, and 2.2 using rails versions 4.0, 4.1, and 4.2.

*From what I can tell it doesn't work with ruby version 2.2 with rails version 4.0, but I assume you wouldn't use those together, right?*

[![Build Status](https://travis-ci.org/pdebelak/jump_back.svg?branch=master)](https://travis-ci.org/pdebelak/jump_back)

## Installation

Add this line to your application's Gemfile:

    gem 'jump_back', '~> 0.2.1'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jump_back

## Usage

### redirect_back

`redirect_back` examples:

    def an_action
      # will redirect_to :back if there is an HTTP_REFERER
      # and to root_path if there isn't a referer
      redirect_back
    end
    
    def an_action
      # will redirect_to :back if there is an HTTP_REFERER
      # and to a_different_path if there isn't a referer
      redirect_back(a_different_path)
    end
    
By default, `redirect_back` will not redirect to referers that are from a different domain. You can overwrite this by flagging `offsite: true`. It will work normally with local referers.
    
    def secret_content
      # if referer is anothersite.com, will redirect_to root_path
      redirect_back unless logged_in? # assuming you have a logged_in? method you want to check
    end
    
    def secret_content
      # if referer is anothersite.com, will redirect_to anothersite.com
      redirect_back(offsite: true) unless logged_in?
    end
    
    def secret_content
      # if referer not present, will redirect_to a_different_path
      redirect_back(a_different_path, offsite: true) unless logged_in?
    end
    
You can also pass the normal options you would pass to `redirect_to`.

    def eaten_by_bears
      redirect_back alert: "You've been eaten by bears!", status: 302
    end
    
    def many_options
      redirect_back a_different_path, offsite: true, notice: "A lot of options", status: :found
    end
    
### return_to_referer

First you need to call `save_referer`. This will store the referer in `session[:jump_back_stored_referer]`. This `session` value will not be overwritten if it exists. This is to avoid undesired redirects after things like failed form posts.

    def an_action
      save_referer
    end
    
    def another_action
      # this will not overwrite the previously saved referer
      save_referer
    end
    
    def a_third_action
      # this will clear the referer so it can be saved over
      clear_referer
      # the new referer will be saved
      save_referer
    end
      
Once you have saved the referer, you can call `return_to_referer`.

    def action_with_redirect
      # will redirect_to saved referer or root_path if a referer was not saved
      return_to_referer
    end
    
    def action_with_redirect
      # will redirect_to saved referer or a_different_path if a referer was not saved
      return_to_referer a_different_path
    end
    
`return_to_referer` also accepts options to pass to `redirect_to`.

    def action_with_notice
      return_to_referer notice: 'A notice'
    end
    
    def many_options
      return_to_referer a_different_path, alert: 'Many options!', status: 302
    end

## Contributing

1. Fork it ( https://github.com/pdebelak/jump_back/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

I welcome contributions or feature requests. Open an issue if there is a feature you'd like to see.