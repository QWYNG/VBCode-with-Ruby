require './vb_with_ruby'

file = ARGV.first

File.open(file) do |f|
  loop do
    buf = f.read(8)
    break unless buf

    tag_length, vb_code_length = buf.unpack('N2')

    tag = f.read(tag_length)
    vb_codes = f.read(vb_code_length)

    numbers = []
    previous_number = 0

    VbCode.vb_decode(vb_codes).each do |decode_number|
      numbers.push(decode_number + previous_number)
      previous_number += decode_number
    end

    File.open('encoded.txt', 'a') do |decoded_file|
      decoded_file.write(format("%s\t%s\n", tag, numbers.join(',')))
    end
  end
end