SimpleCov.start do
  add_filter "/features/"
  add_filter "/spec/"
  add_filter "/tmp"
  add_filter "/db"

  add_group "lib", "lib"
end
