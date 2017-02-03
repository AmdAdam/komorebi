//
//  Copyright (C) 2015-2016 Abraham Masri <imasrim114@gmail.com>
//
//  This program is free software: you can redistribute it and/or modify it 
//  under the terms of the GNU Lesser General Public License version 3, as published    
//  by the Free Software Foundation.
//  
//  This program is distributed in the hope that it will be useful, but 
//  WITHOUT ANY WARRANTY; without even the implied warranties of    
//  MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR  
//  PURPOSE.  See the GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License along 
//  with this program.  If not, see <http://www.gnu.org/licenses/>  

using Gtk;
using Cairo;

namespace Komorebi.OnScreen {

    public class InfoBox: Box {

        // Labels box
        Gtk.Box mainContainer = new Box(Orientation.HORIZONTAL, 5);

        // RAM Image and label
        Gtk.Box ramContainer = new Box(Orientation.VERTICAL, 5);
        Gtk.Image ramImage = new Image();
        Gtk.Label ramLabel = new Label("1.5/4.0GB");

        // CPU Image and label
        Gtk.Box cpuContainer = new Box(Orientation.VERTICAL, 5);
        Gtk.Image cpuImage = new Image();
        Gtk.Label cpuLabel = new Label("54.4%");


        // Time updater
        public uint timeout;

        public InfoBox () {

            orientation = Orientation.HORIZONTAL;
            spacing = 50;
            margin = 30;

            initInfoWidgets();

            // Add widgets
            ramContainer.add(ramImage);
            ramContainer.add(ramLabel);

            cpuContainer.add(cpuImage);
            cpuContainer.add(cpuLabel);

            add(ramContainer);
            add(cpuContainer);
        }


        void initInfoWidgets () {

        	// Images first
        	ramImage.set_from_file("/System/Resources/Komorebi/ram_light.svg");
        	cpuImage.set_from_file("/System/Resources/Komorebi/cpu_64_light.svg");


            Timeout.add(500, () => {

                /* Memory */
                GTop.Mem mem;
                GTop.get_mem (out mem);
                
                var totalMemory = (float) (mem.total / 1024 / 1024) / 1000;
                var usedMemory = (float) (mem.used  / 1024/ 1024) / 1000;

                ramLabel.set_markup(@"<span color='white' font='Lato Regular 10'>$(usedMemory)/%.2fGB</span>".printf(totalMemory));
                
                /* CPU */
                GTop.Cpu cpu_data;
                GTop.get_cpu (out cpu_data);
                var used = cpu_data.user + cpu_data.nice + cpu_data.sys;
                var cpu_load = ((double) (used - 0)) / (cpu_data.total - 0);


                cpuLabel.set_markup(@"<span color='white' font='Lato Regular 10'>$(cpu_load)%</span>");

                return true;
            });

        }


    }
}