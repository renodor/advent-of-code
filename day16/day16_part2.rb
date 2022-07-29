# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/16#part2

require 'pry'

input = File.open('./day16/day16_input.txt').read

hexa_to_binary = {
  '0' => '0000',
  '1' => '0001',
  '2' => '0010',
  '3' => '0011',
  '4' => '0100',
  '5' => '0101',
  '6' => '0110',
  '7' => '0111',
  '8' => '1000',
  '9' => '1001',
  'A' => '1010',
  'B' => '1011',
  'C' => '1100',
  'D' => '1101',
  'E' => '1110',
  'F' => '1111'
}.freeze

packet = input.chars.map { |char| hexa_to_binary[char] }.join('')

def decode_packet(packet)
  packet.slice!(..2).to_i(2)
  type = packet.slice!(..2).to_i(2)

  if type == 4
    literal_value = []
    loop do
      five_bits = packet.slice!(..4)
      literal_value << five_bits.slice(1..)
      break if five_bits[0].to_i.zero?
    end

    return literal_value.join.to_i(2)
  end

  results = []

  if packet.slice!(0).to_i.zero?
    subpacket_length = packet.slice!(..14).to_i(2)
    subpacket        = packet.slice!(..subpacket_length - 1)
    results << decode_packet(subpacket) while subpacket.size.positive?
  else
    number_of_subpackets = packet.slice!(..10).to_i(2)
    number_of_subpackets.times { results << decode_packet(packet) }
  end

  case type
  when 0
    results.sum
  when 1
    results.reduce(:*)
  when 2
    results.min
  when 3
    results.max
  when 5
    results[0] > results[1] ? 1 : 0
  when 6
    results[0] < results[1] ? 1 : 0
  when 7
    results[0] == results[1] ? 1 : 0
  end
end

puts decode_packet(packet)
