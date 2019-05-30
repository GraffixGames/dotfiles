#!/usr/bin/env python3
import os, random, re

# can`t figure out how to use env when running on boot, please help
home_path = '/home/noah'
random.seed()

def random_wallpaper():
    wallpaper_folder = os.path.join(home_path, 'Pictures/Wallpapers/')
    wallpaper_path = random.choice([x for x in os.listdir(wallpaper_folder) if os.path.isfile(os.path.join(wallpaper_folder, x))])
    return os.path.join(wallpaper_folder, wallpaper_path)

def main():
    template_path = os.path.join(home_path, '.config/sway/config_template')
    with open(template_path, 'r') as file:
        data = file.read()

    template_file = open(template_path, 'r')
    config_path = os.path.join(home_path, '.config/sway/config')
    wallpaper_path = random_wallpaper()
    updated_data = re.sub(r'{{{ wallpaper-path }}}', str(wallpaper_path), data)

    with open(config_path, 'w') as file:
        file.writelines(updated_data)

if __name__ == '__main__':
    main()
