module SliderHelper

    # Creates a slider control out of an element.
  def slider_element(element_id, options={})
    prepare = "Element.cleanWhitespace('#{element_id}');"
    
    [:change, :slide].each do |k|
      if options.include?(k)
        name = 'on' + k.to_s.capitalize
        options[name] = "function(value){#{options[k]}}"
        options.delete k
       end
    end
    
    [:handles, :spans, :axis].each do |k|
      options[k] = array_or_string_for_javascript(options[k]) if options[k]
    end
    
    if options[:slider_value]
      options[:sliderValue] = array_or_numeric_for_javascript(options[:slider_value])
      options.delete :slider_value
    end
    
    options[:range] = "$R(#{options[:range].min},#{options[:range].max})" if options[:range]
    
    handle = options[:handles] || "$('#{element_id}').firstChild"
    options.delete :handles
            
    javascript_tag("#{prepare}new Control.Slider(#{handle},'#{element_id}', #{options_for_javascript(options)})")
  end
  
  # Creates a simple slider control and associates it with a hidden text field
  def slider_field(object, method, options={})
    options.merge!({ 
      :change => "$('#{object}_#{method}').value = value",
      :slider_value  => instance_variable_get("@#{object}").send(method)
    })
    hidden_field(object, method) <<        
    content_tag('div',content_tag('div', ''), 
      :class => 'slider', :id => "#{object}_#{method}_slider") << 
    slider_element("#{object}_#{method}_slider", options)
  end
  
  def slider_stylesheet
    content_tag("style", <<-EOT
      div.slider {
        width: 150px;
        height: 5px;
        margin-top:5px;
        margin-bottom:5px;
        background: #ddd;
        position: relative;
      }
      div.slider div {
        position:absolute;
        width:8px;
        height:15px;
        margin-top:-5px;
        background: #999;
        border:1px outset white;
      }
    EOT
    )
  end

  private
    def options_for_javascript(options)
      '{' + options.map {|k, v| "#{k}:#{v}"}.sort.join(', ') + '}'
    end

    def array_or_string_for_javascript(option)
      js_option = if option.kind_of?(Array)
        "['#{option.join('\',\'')}']"
      elsif !option.nil?
        "'#{option}'"
      end
      js_option
    end
    
    def array_or_numeric_for_javascript(option)
      js_option = if option.kind_of?(Array)
        "[#{option.join('\',\'')}]"
      elsif !option.nil?
        "#{option}"
      end
      js_option
    end

end