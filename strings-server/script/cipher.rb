#!/usr/bin/env ruby

require "openssl"

p plain = ("a".."z").to_a.shuffle.join

cipher = OpenSSL::Cipher.new("aes-128-ecb").encrypt
cipher.key = "0123456789abcdef"
p out1 = cipher.update(plain) << cipher.final

cipher = OpenSSL::Cipher.new("aes-128-ecb").encrypt
cipher.key = "0123456789abcdefghi"
p out2 = cipher.update(plain) << cipher.final

p out1 == out2
