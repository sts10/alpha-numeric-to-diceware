require 'rumoji'

class Passphrase
  attr_reader :passphrase
  def initialize(random_base_thirty_six)
    base_six_string = ""
    random_base_thirty_six.upcase.each_char do |char|
      base_six_string = base_six_string + self.to_base_six(char)
    end

    dice_words = self.import_word_list

    @passphrase = []
    base_six_string.scan(/...../).each do |dice_roll|
      @passphrase << dice_words[dice_roll]
    end
  end

  def to_base_six(base_thirty_six)
    convert = {
      '0' => '11', '1' => '12', '2' => '13', '3' => '14', '4' => '15', '5' => '16', '6' => '21', '7' => '22', '8' => '23', '9' => '24', 'A' => '25', 'B' => '26', 'C' => '31', 'D' => '32', 'E' => '33', 'F' => '34', 'G' => '35', 'H' => '36', 'I' => '41', 'J' => '42', 'K' => '43', 'L' => '44', 'M' => '45', 'N' => '46', 'O' => '51', 'P' => '52', 'Q' => '53', 'R' => '54', 'S' => '55', 'T' => '56', 'U' => '61', 'V' => '62', 'W' => '63', 'X' => '64', 'Y' => '65', 'Z' => '66', 
    }

    convert[base_thirty_six.to_s]
  end

  def import_word_list
    dice_words ={}
    File.open("eff_large_wordlist.txt", "r") do |f|
      f.each_line do |line|
        dice_words[line.split(" ")[0]] = line.split(' ')[1].lstrip.rstrip
      end
    end
    dice_words
  end
end

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
my_passphrase = Passphrase.new(base_thirty_six_string)

puts "Your Diceware passphrase is:"
puts my_passphrase.passphrase.join(' ')
puts my_passphrase.passphrase.join('')

puts ''

my_emojiphrase = Emojiphrase.new(base_thirty_six_string)

puts "Your Emoji passphrase is:"
puts my_emojiphrase.passphrase.join(' ')
puts my_emojiphrase.passphrase.join('')

fileHtml = File.new("emojipassphrase.html", "w+")
fileHtml.puts my_emojiphrase.passphrase.join('')
fileHtml.close()
