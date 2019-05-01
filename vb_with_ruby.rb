module VbCode
  class << self
    def vb_encode(number)
      bytes = []
      loop do
        bytes.unshift(number % 128)
        break if number < 128

        number /= 128
      end
      bytes[-1] += 128
      bytes.pack('C*')
    end

    def vb_decode(vb_code)
      n = 0
      vb_code.unpack('C*').each_with_object(decode_numbers = []) do |unpacked_code|
        if unpacked_code < 128
          n = 128 * n + unpacked_code
        else
          decode_numbers.push(128 * n + (unpacked_code - 128))
          n = 0
        end
      end
    end
  end
end
