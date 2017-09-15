require 'rubygems'
require 'aws-sdk'
require 'csv'
load "./local_env.rb" 
Aws.use_bundled_cert!
def push_b()
  Aws::S3::Client.new(
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION']
   )
  bucket = 'isbn-filter'
  file   = 'output_isbn_file.csv'
  s3 = Aws::S3::Resource.new(region: 'us-east-2')
  obj = s3.bucket(bucket).object(file)
 
# # string data
obj.put(body: '"some code here to show something being added to the bucket."+ "\n"')
File.open('output_isbn_file.csv', 'rb') do |file|
        obj.put(body: file)
    end
 #    obj.puts(body:'Hello World!')
   
  end
 
# def push_to
# :access_key_id => ENV['S3_KEY']
# :secret_access_key => ENV['S3_SECRET'] 
# bucket => ENV['S3_BUCKET']
# file => ENV['S3File']
# end

# def csv_func
# 	big_array = [] 
# CSV.foreach('input_isbn_file.csv') do |row|
#    	row.inspect
#         stuff = isbn_check(row[1]).to_s
#         if stuff == "true"

# 			stuff = "valid"
# 		elsif stuff == "false"
# 			stuff = "invalid"
# 		else
# 		end
#         row << stuff
#         row
#        big_array << row.join(",")
       
#     CSV.open("output_isbn_file.csv", "w" ,  ) do |out|
# 		out << big_array
# 		out
# 		p out 
# end
# end
# end

def csv_func
    write_file = File.open("output_isbn_file.csv", "w" , { :col_sep => "\n" , :row_sep => "\n"} )

    CSV.foreach('input_isbn_file.csv') do |row|
        if isbn_check(row[1]).to_s== "true"
            row << ("valid")
                else
            row << ("invalid")

        end
    
          write_file.puts row[0] + "," + row[1] + "," + row[2]

   end
end


def clean(number)
	string = number
	string = string.gsub("-", "")
	string = string.gsub(" ", "")
	string = string.delete(' ') 
end


def isbn_length_10(number)
	   string = number
	if string.length == 10 
	 true
	else 
	false
end
end

def isbn_length_13(number)
	  string = number
	if string.length == 13
	 true
	else 
	false
end
end

def numbers_only(number)
 if number !~ /\D/	
 	true
elsif
	number.chop !~ /\D/
	true
else 
	false
end 
end

def check_class(number) 

if number.is_a? String 
elsif number.is_a? Array
number = "#{number}".join("",'')
number = number.to_s
elsif  number.is_a? Integer
number = number.to_s
else 
	false
end
number.is_a? String
end 

def math_isbn_10(number)
isbn = number
isbn = isbn.scan /\w/
isbn = isbn[0..9]
total = (1*isbn[0].to_i) + (2*isbn[1].to_i) + (3*isbn[2].to_i) + (4*isbn[3].to_i) + (5*isbn[4].to_i) + (6*isbn[5].to_i) + (7*isbn[6].to_i) + (8*isbn[7].to_i) + (9*isbn[8].to_i) 
# p total 
check_sum = total % 11
if check_sum == 10 
	check_sum = ("x").to_s
else
end
if check_sum.to_s == isbn[9]

	 true
else
	 false
end
end



def math_isbn_13(number)
isbn = number
isbn = isbn.scan /\w/
isbn = isbn[0..12]
total = (1*isbn[0].to_i) + (3*isbn[1].to_i) + (1*isbn[2].to_i) + (3*isbn[3].to_i) + (1*isbn[4].to_i) + (3*isbn[5].to_i) + (1*isbn[6].to_i) + (3*isbn[7].to_i) + (1*isbn[8].to_i) + (3*isbn[9].to_i) + (1*isbn[10].to_i) + (3*isbn[11].to_i) 
total = total % 10
ten = 10
post_total = ten - total
post_total = post_total % 10
isbn[12] = isbn[12]
if post_total.to_s == isbn[12]
	true
else
	false
end
end

def isbn_check(number)
	if check_class(number) == true
		number = clean(number)
		if numbers_only(number) == true
			if isbn_length_10(number) == true
				math_isbn_10(number)
			elsif isbn_length_13(number) == true
				math_isbn_13(number)
			else 
				false
			end
		else
			false
		end
	else
		false
	end
end 

def isbn_text(number)
if number == true
	number = "a valid ISBN"
elsif number == false
	number = "not a valid ISBN"
else
end
number
end 
  
csv_func
push_b()
