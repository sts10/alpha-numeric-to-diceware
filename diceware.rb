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

puts "Enter a random string containing only letters and numbers. Lowercase letters will be capitalized."
base_thirty_six_string = gets.chomp
my_passphrase = Passphrase.new(base_thirty_six_string)

puts ''
puts "Your Diceware passphrase is:"
puts my_passphrase.passphrase.join('')
puts my_passphrase.passphrase.join('-')
puts my_passphrase.passphrase.join(' ')

