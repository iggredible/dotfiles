desc "Installing dotfiles into system"
task :install do

  # TODO: install homebrew - DONE
  install_homebrew if is_darwin?

  # TODO: install Vim dependencies
end

desc "Updating installed programs"
task :update do
  Rake::Task["install"].execute
end

private

def is_darwin?
  RUBY_PLATFORM.include?("darwin")
end

def install_homebrew
  system %(which brew)
  unless $?.success?
    system %(bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)")
  end

  puts "Updating homebrew..."
  system %(brew update)

  puts "Installing brew packages"
  system %(brew install fzf universal-ctags ripgrep)
end

