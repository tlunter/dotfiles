require 'rake'

files = {
  'coc/package.json' => '.config/coc/extensions/package.json',
  'git/gitconfig.symlink' => '.gitconfig',
  'git/gitignore.symlink' => '.gitignore',
  'oh-my-zsh/plugins/tlunter' => '.oh-my-zsh/custom/plugins/tlunter',
  'oh-my-zsh/themes/tlunter.zsh-theme' => '.oh-my-zsh/custom/themes/tlunter.zsh-theme',
  'python/startup.symlink' => '.pystartup',
  'tmux/tmux.symlink' => '.tmux.conf',
  'vim/colors' => '.vim/colors',
  'vim/vimrc.symlink' => '.vimrc',
  'X11/wallpaper.symlink' => '.background/wallpaper.sh',
  'X11/xinit.symlink' => '.xinitrc',
  'X11/xmobar-bottom.symlink' => '.xmobar-botrc',
  'X11/xmobar.symlink' => '.xmobarrc',
  'X11/xmonad.symlink' => '.xmonad/xmonad.hs',
  'X11/Xresources.symlink' => '.Xresources',
  'zsh/zshenv.symlink' => '.zshenv',
  'zsh/zshrc.symlink' => '.zshrc'
}

desc "Install one file to the given symlink"
task :copy_file, :dotfile, :symlink do |t, args|
  dotfile = args[:dotfile]
  symlink = args[:symlink]
  raise "No dotfile given!" if dotfile.nil?
  raise "No symlink given!" if symlink.nil?

  dotfile_path = File.expand_path(dotfile)
  if File.exist?(dotfile_path)
    symlink_path = File.expand_path(File.join('~', symlink))
    old_symlink_path = symlink_path + ".orig"
    FileUtils.mkdir_p(File.dirname(symlink_path))
    if File.exist?(old_symlink_path)
      File.delete(old_symlink_path)
    end
    if File.exist?(symlink_path)
      FileUtils.move(symlink_path, symlink_path + ".orig")
    end
    FileUtils.ln_s(dotfile_path, symlink_path)
  end
end

desc "Remove the original file for this symlink"
task :cleanup_file, :symlink do |t, args|
  symlink = args[:symlink]
  raise "No symlink given!" if symlink.nil?

  symlink_path = File.expand_path(File.join('~', symlink))
  old_symlink_path = symlink_path + '.orig'
  if File.exist?(old_symlink_path)
    File.delete(old_symlink_path)
  end
end

desc "Copies symlink files to dotfiles"
task :copy do
  files.each do |dotfile, symlink|
    Rake::Task[:copy_file].invoke(dotfile, symlink)
    Rake::Task[:copy_file].reenable
  end
end

desc "Cleans up all original files"
task :cleanup do
  files.each do |dotfile, symlink|
    Rake::Task[:cleanup_file].invoke(symlink)
    Rake::Task[:cleanup_file].reenable
  end
end

desc "Installs the files and cleans up the old"
task :install => [:copy, :cleanup]
