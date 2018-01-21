
def get_no_of_threads()
  if ENV['COUNT'] != nil
    return ENV['COUNT']
  else
    return @@count
  end   
end

def get_loop_count()
  if ENV['LOOP'] != nil
    return ENV['LOOP']
  else
    return 1
  end   
end

def get_ramp_up()
  if ENV['RAMPUP'] != nil
    return ENV['RAMPUP']
  else
    return 10
  end   
end

def get_domain(api)
   select case api
     when "GetCustomer"
       return {:domain => 'apiite02', :protocol => 'https', :port => '8443',:connect_timeout => '600000', :response_timeout => '600000'}  
     when "get_account"
       return {:domain => 'apiite02', :protocol => 'https', :port => '8443',:connect_timeout => '600000', :response_timeout => '600000'}  
     end
end

def get_header(api)
   select case api
     when "GetCustomer"
       return [{name: 'ContextId', value: '123' },{name: 'APIVersion', value: '1.0' },{ name: 'AppName', value: 'IDM'},{ name: 'UserId', value: 'Testuser' }]
     when "get_account"
       return "header 2"
     end
end

def get_host_url(api,account)
    
   select case api
     when "GetCustomer"
       return "/customer-information-api/v1/uk-credit-cards/cards/#{account}/customers"
     when "get_account"
       return "header 2"
     end
end


def process_results(file_name)
   count = 0
   total = 0
   min_res = 0
   max_res =0
   failure =0
   
   File.open(file_name).each do |line|
     count += 1
     time,response_time,name,response_code,thread_name,pass = line.split('|')
     response_time = response_time.to_i
     total += response_time
     
     if response_code.to_i != 200
       failure += 1
     end    

     if count ==1
        min_res = response_time
        max_res = response_time
     else
        min_res = [min_res,response_time].min
        max_res = [max_res,response_time].max
     end
   end
   avg_res = total / count

   puts "Total Hits: #{count}"
   puts "Average Res time: #{avg_res}"
   puts "Minimun Res time: #{min_res}"
   puts "Maximun Res time: #{max_res}"
   puts "Total failures: #{failure}"

   return max_res, failure
end

def clean_files(file_name)
   path_to_file = Dir.pwd +  "/"  + file_name
   File.delete(path_to_file) if File.exist?(path_to_file)
end  

def define_file(file_name,extn)
   path_to_file = Dir.pwd
   if extn == "jtl"
      return path_to_file + "/results/" + Time.now.strftime("%d_%m_%Y_%H_%M") + "_#{file_name}.#{extn}"
   else
      return path_to_file  + "/#{file_name}.#{extn}"
   end   
end  

