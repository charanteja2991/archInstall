# view cache size
du -sh /var/cache/pacman/pkg/

# clean unused packages
sudo pacman -Sc

#clean all cached packages
sudo pacman -Scc

# Remove Orphaned Packages
# List orphans
pacman -Qdt

# Remove orphans
sudo pacman -Rns $(pacman -Qdtq)

# Clean system temp
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clean user cache
rm -rf ~/.cache/*

# Clean yay cache
yay -Sc
