# caesar-cipher.rb

require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
    erb :plaintext
end

post '/' do
    
    phrase = params[:plaintext].strip
    key = params[:key].strip.to_i
    
    secret = encode(phrase, key)
    
    erb :encrypted, :locals => { :phrase => phrase, :secret => secret }
end

def wrap(char, shift_value)
    # Wrap around to start of alphabet
    if char =~ /\p{lower}/
      if shift_value > 'z'.ord
        shift_value = 'a'.ord + (shift_value - 'z'.ord - 1)
      end
    elsif shift_value > 'Z'.ord
      shift_value = 'A'.ord + (shift_value - 'Z'.ord - 1)
    end

    shift_value
end

def encode(phrase, key)
    return '' if phrase == ''

    return phrase if key < 1

    encode_string = ''

    phrase.each_char do |char|
      # Only shift [A-Za-z]
      if char =~ /\p{alpha}/
        shift_value = wrap(char, char.ord + key)
      else
        shift_value = char.ord
      end

      encode_string += shift_value.chr
    end

    encode_string
end