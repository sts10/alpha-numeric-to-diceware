require 'rumoji'

class Emojiphrase
  attr_reader :passphrase
  def initialize(random_base_thirty_six)
    emoji_numbers = self.generate_emoji_numbers(random_base_thirty_six)
    emoji_list = self.import_emoji_list

    @passphrase = []
    emoji_numbers.each do |emoji_number|
      @passphrase << Rumoji.decode(":#{emoji_list[emoji_number]}:")
    end
  end

  def generate_emoji_numbers(random_base_thirty_six)
    emoji_numbers = []
    convert = { '0' => 1, '1' => 2, '2' => 3, '3' => 4, '4' => 5, '5' => 6, '6' => 7, '7' => 8, '8' => 9, '9' => 10, 'A' => 11, 'B' => 12, 'C' => 13, 'D' => 14, 'E' => 15, 'F' => 16, 'G' => 17, 'H' => 18, 'I' => 19, 'J' => 20, 'K' => 21, 'L' => 22, 'M' => 23, 'N' => 24, 'O' => 25, 'P' => 26, 'Q' => 27, 'R' => 28, 'S' => 29, 'T' => 30, 'U' => 31, 'V' => 32, 'W' => 33, 'X' => 34, 'Y' => 35, 'Z' => 36 }
    random_base_thirty_six.upcase.scan(/../).each do |pair|
      emoji_numbers << (convert[pair[0]] * convert[pair[1]])
    end
    emoji_numbers
  end

  def import_emoji_list
    emoji_titles = []
    File.open("emoji.txt", "r") do |f|
      f.each_line do |line|
        emoji_titles << line.split(',')[0]
      end
    end
    emoji_titles
  end
end

puts "Enter a random string containing only letters and numbers. Lowercase letters will be capitalized."
base_thirty_six_string = gets.chomp
puts ''

my_emojiphrase = Emojiphrase.new(base_thirty_six_string)

puts "Your Emoji passphrase is:"
puts my_emojiphrase.passphrase.join(' ')
puts my_emojiphrase.passphrase.join('')

fileHtml = File.new("emojipassphrase.html", "w+")
fileHtml.puts my_emojiphrase.passphrase.join('')
fileHtml.close()
