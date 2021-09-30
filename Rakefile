desc "Installing programs"
namespace :install do

  task :check_osx do
    if is_darwin?
      puts "Yay, Mac user!"
      puts "Installing/ Checking Homebrew..."
      install_homebrew 
      update_homebrew
    else
      abort("You are not using OSX")
    end
  end

  task :tmux => [:check_osx, :tmux_packages, :tmux_files]

  task :tmux_packages do
    install_homebrew_packages('tmux')
  end

  task :tmux_files do
    install_files('tmux.conf')
  end

  task :vim => [:check_osx, :vim_packages, :vim_plug]

  task :vim_packages do
    install_homebrew_packages('vim fzf universal-ctags ripgrep')
  end

  task :vim_plug do
    install_vim_plug unless vim_plug_exists?
  end

  task :vim_files do
    install_files('vimrc vim')
  end
end

desc "Updating installed programs"
namespace :update do
  task :vim do
    Rake::Task["install:vim"].execute
  end

  task :tmux do
    Rake::Task["install:tmux"].execute
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
  File.exist? vim_plug_path
end

def install_files(files)
  files = files.split(' ')
  files.each do |file|
    original_file = %(#{ENV["HOME"]}/.#{file})
    dotfiles_file = %(#{ENV["PWD"]}/#{file})

    if File.exist?(original_file) &&
       (!File.symlink?(original_file) || 
       (File.symlink?(original_file) &&
        File.readlink(original_file) != dotfiles_file))

        puts "Moving #{original_file} to #{original_file}.bak"
        system %(mv #{original_file} #{original_file}.bak)
    end

    puts "Symlinking #{original_file.blue} to #{dotfiles_file.cyan.bold}"
    system %(ln -sf #{dotfiles_file} #{original_file})
  end
end


class String
  def blue;           "\e[34m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
end

