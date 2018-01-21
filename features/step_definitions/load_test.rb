
Given(/^there are (\d+) users$/) do |arg1|
  @@count = arg1
end

Given(/^each user hit the getcustomer simultaniously$/) do
  @api = "GetCustomer"
  @result_file_name = define_file(@api,"jtl")
  user = build(:user1) 
  
  test do
    threads :count => get_no_of_threads, :loops => get_loop_count, :rampup => get_ramp_up, :scheduler => false,  :delay => 0, :on_sample_error => "startnextloop" do
      # setup configs
      defaults(get_domain("GetCustomer"))
      # setup header
      header get_header("GetCustomer")
      #Customer API
      visit name: @api, url: get_host_url("GetCustomer",user.pan), method: 'GET' 
      # pause time in milliseconds
      think_time 200
    end
 end.run(
  debug: true,
  # path/name to output JMeter logs
  file: define_file("Test_Plan_get_customer","jmx"),
  log:  define_file("perf_log","log"),
  jtl:  @result_file_name
  )
end

Then(/^each user should get a response within (\d+)$/) do |arg1|
 max_res, failure = process_results(@result_file_name)

 if failure.to_i ==0 
   if max_res.to_i < arg1.to_i
    puts "Test Pass"
   else
    fail!(raise(ArgumentError.new("Maximum Response: #{max_res} exeed the threshold!")))
   end  
 else
    fail!(raise(ArgumentError.new("#{failure} - hits got response code other than 200")))
 end  

end




















  # defaults({
      #  :domain => 'apiite02', :protocol => 'https', :port => '8443',
      #  :connect_timeout => '600000', :response_timeout => '600000'
      # })

 #header [{name: 'ContextId', value: '123' },{name: 'APIVersion', value: '1.0' },{ name: 'AppName', value: 'IDM'},{ name: 'UserId', value: 'Testuser' }]

