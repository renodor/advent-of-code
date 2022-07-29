# frozen_string_literal:true

# Instructions: https://adventofcode.com/2021/day/16

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
  version = packet.slice!(..2).to_i(2)
  type    = packet.slice!(..2).to_i(2)

  if type == 4
    loop { break if packet.slice!(..4)[0].to_i.zero? }
  elsif packet.slice!(0).to_i.zero?
    subpacket_length = packet.slice!(..14).to_i(2)
    subpacket        = packet.slice!(..subpacket_length - 1)
    version         += decode_packet(subpacket) while subpacket.size.positive?
  else
    number_of_subpackets = packet.slice!(..10).to_i(2)
    number_of_subpackets.times { version += decode_packet(packet) }
  end

  version
end

puts decode_packet(packet)
