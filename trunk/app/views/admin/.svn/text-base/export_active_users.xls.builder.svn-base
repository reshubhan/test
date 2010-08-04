xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet",
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet"
  }) do

  xml.Worksheet 'ss:Name' => 'Active Users' do
    xml.Table do

      # Header
      xml.Row do
          xml.Cell { xml.Data 'Login', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Firstname', 'ss:Type' => 'String' } if @export[:firstname]
          xml.Cell { xml.Data 'Lastname', 'ss:Type' => 'String' } if @export[:lastname]
          xml.Cell { xml.Data 'Email', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Email Alias', 'ss:Type' => 'String' } if @export[:email_alias]
          xml.Cell { xml.Data 'Role', 'ss:Type' => 'String' } if @export[:role_name]
          xml.Cell { xml.Data 'Plan', 'ss:Type' => 'String' } if @export[:plan_name]
          xml.Cell { xml.Data 'Organization Name', 'ss:Type' => 'String' } if @export[:organization_name]
          xml.Cell { xml.Data 'Organization Type', 'ss:Type' => 'String' } if @export[:organization_type]
          xml.Cell { xml.Data 'Zip', 'ss:Type' => 'String' } if @export[:zip]
          xml.Cell { xml.Data 'Telephone', 'ss:Type' => 'String' } if @export[:telephone]
          xml.Cell { xml.Data 'Sign up date', 'ss:Type' => 'String' } if @export[:sign_up_date]
          xml.Cell { xml.Data 'Last login date', 'ss:Type' => 'String' } if @export[:last_login_date]
          xml.Cell { xml.Data 'No of Postings', 'ss:Type' => 'String' } if @export[:no_of_postings]
      end

      # Rows
      for user in @users
        xml.Row do
            xml.Cell { xml.Data user.login, 'ss:Type' => 'String' }
            xml.Cell { xml.Data user.profile.firstname, 'ss:Type' => 'String' } if @export[:firstname]
            xml.Cell { xml.Data user.profile.lastname, 'ss:Type' => 'String' } if @export[:lastname]
            xml.Cell { xml.Data user.profile.email, 'ss:Type' => 'String' }
            xml.Cell { xml.Data user.email_alias, 'ss:Type' => 'String' } if @export[:email_alias]
            xml.Cell { xml.Data user.plan.role.title, 'ss:Type' => 'String' } if @export[:role_name]
            xml.Cell { xml.Data user.plan.name, 'ss:Type' => 'String' } if @export[:plan_name]
            if @export[:organization_name]
              xml.Cell { xml.Data user.profile.organization_name, 'ss:Type' => 'String' }
            end
            if @export[:organization_type]
              if user.profile.organization_type
                xml.Cell { xml.Data user.profile.organization_type.name, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
            end
            xml.Cell { xml.Data user.profile.zip, 'ss:Type' => 'String' } if @export[:zip]
            xml.Cell { xml.Data user.profile.telephone, 'ss:Type' => 'String' } if @export[:telephone]
            xml.Cell { xml.Data user.created_at.strftime("%a %b %d, %Y"), 'ss:Type' => 'String' } if @export[:sign_up_date]
            if @export[:last_login_date]
              if user.last_user_activity
                xml.Cell { xml.Data user.last_user_activity.strftime("%a %b %d, %Y"), 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
            end
            
            xml.Cell { xml.Data user.no_of_postings, 'ss:Type' => 'Number' } if @export[:no_of_postings]
        end
      end

    end
  end
end