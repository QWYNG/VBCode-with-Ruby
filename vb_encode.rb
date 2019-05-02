require './vb_code'

file = ARGV.first

File.open(file, 'r+b') do |f|
  f.each_line(chomp: true) do |line|
    (tag, numbers) = line.split("\t")

    vb_code = ''
    previous_number = 0

    numbers.split(',').map(&:to_i).each do |number|
      vb_code << VbCode.vb_encode(number - previous_number)
      previous_number = number
    end


    File.open("#{File.basename(file, '.*')}.bin", 'a') do |encoded_file|
      encoded_file.write([tag.length, vb_code.length].pack('N2'), tag, vb_code)
    end
  end
end
