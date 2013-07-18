module BootstrapHelper
    def tabify list
        r = '<ul class="nav nav-tabs">'
        active = true
        list.each_pair do |li, str|
            if content_for? li
                r << "
                "
                if active
                    r << '<li class="active"><a data-toggle="tab" href="#'+li.to_s+'">'+str+'</a></li>'
                    active = false
                else
                    r << '<li><a data-toggle="tab" href="#'+li.to_s+'">'+str+'</a></li>'
                end
            end
        end
        r << '</ul>'
        r << "

        "
        r << '<div class="tab-content" style="border: thin inset black; margin-top: 0px; background-color: #fff; padding: 5px;">'
        list.each_pair do |li, str|
            if content_for? li
                if !active
                    r << '<div class="tab-pane active" id="'+li.to_s+'">'
                    active = true
                else
                    r << '<div class="tab-pane" id="'+li.to_s+'">'
                end
                r << "
                "
                r << content_for(li)
                r << "
                "
                r << '</div>'
                r << "
                "
            end
        end
        r << '</div>'
        r.html_safe
    end

    def twitterized_type(type)
        case type
        when :alert
            "warning"
        when :error
            "error"
        when :notice
            "info"
        when :success
            "success"
        else
            type.to_s
        end
    end

    def truthy_thumb(value)
        if value=="*"
            i('star').html_safe
        elsif value
            i('thumbs-up').html_safe
        else
            i('thumbs-down').html_safe
        end
    end

    def i(c,w=false)
        ('<i class="icon-' + c + (w ? " icon-white " : '') + '"></i>').html_safe
    end

    def pills_for collection, klass = nil
        buffer = '<ul class="nav nav-pills ' + (klass ? klass : '') + '">' + "\n"
        collection.each do |item|
            buffer << '<li>' + link_to(item.display, item) + '</li>' + "\n"
        end
        buffer << '</ul>'
        buffer.html_safe
    end

    ALERT_TYPES = [:error, :info, :success, :warning]

    def bootstrap_flash
        flash_messages = []
        flash.each do |type, message|
            next if message.blank?

            type = :success if type == :notice
            type = :error if type == :alert
            next unless ALERT_TYPES.include?(type)

            Array(message).each do |msg|
                text = content_tag(:div,
                                   content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                                   msg.html_safe, :class => "alert fade in alert-#{type}")
                flash_messages << text if msg
            end
        end
        flash_messages.join("\n").html_safe
    end
end
