# encoding: utf-8
Then(/then environment contains the following variables/) do
  $stderr.printf("%20s | %-20s\n", 'key', 'value')
  $stderr.printf("%20s+%-20s\n", '-' * 21 , '-' * 21)

  ENV.to_hash.sort_by { |key, value| key }.each do |key, value|
    $stderr.printf("%20s | %-20s\n", key, value)
  end
end
