desc "Installing dotfiles into system"
namespace :install do
  task :vim => [:vim_packages, :vim_plug]

  task :vim_packages do
    if is_darwin?
      install_homebrew 
      update_homebrew
      install_homebrew_packages("vim fzf universal-ctags ripgrep")
    end
  end

  task :vim_plug do
    install_vim_plug unless vim_plug_exists?
  end
end

desc "Updating installed programs"
namespace :update do
  task :vim do
    Rake::Task["install:vim"].execute
  end
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
end

def update_homebrew
  puts "Updating homebrew..."
  system %(brew update)
end

def install_homebrew_packages(packages="")
  unless packages.empty?
    puts "Installing brew packages"
    system %(brew install #{packages})
  end
end

def install_vim_plug
  system %(bash -c "$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)")
  puts "Not called"
end

def vim_plug_exists?
  vim_plug_path = File.join('vim', 'autoload', 'plug.vim')
  File.exists? vim_plug_path
end
