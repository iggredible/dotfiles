desc "Installing dotfiles into system"
task :install do
  puts "hello"
  
  # TODO: install homebrew - DONE
  install_homebrew if is_darwin?
  # TODO: install Vim dependencies
end

def is_darwin?
  RUBY_PLATFORM.include?("darwin")
end

def install_homebrew
  system %{which brew}
  unless $?.success?
    system %{bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"}
  end
end

