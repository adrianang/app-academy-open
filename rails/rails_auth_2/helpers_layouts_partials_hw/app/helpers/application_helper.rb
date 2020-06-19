module ApplicationHelper
  def auth_token
    token_tag = '<input 
                    type="hidden" 
                    name="authenticity_token" 
                    value="#{ form_authenticity_token }"
                />'
    
    token_tag.html_safe
  end
end
