# Roblox Package Manager
Roblox Package Manager (RPM) is a package manager that allows developers to install and publish packages online with ease!
In order to use the plugin, just simply download it [here](https://www.roblox.com/library/7554839261/RPM-Roblox-Package-Manager)!
If you wish to view the source code, you may do so [here](https://github.com/Madonox/Roblox-RPM).

**DISCLAIMER:**
I am NOT responsible for any malicious code that gets inserted into your game!  I try my best to moderate the packages, but I am only one person so it takes time for me to delete malicious packages!

### Creating a package

In order to create a package, you must first install the DemoPackage.  This can be done by opening the plugin, going to Install Package, and entering in DemoPackage.
Once you've installed the package, you may begin editing it as you like!

package.rpm file:
The package.rpm file is basically your package's config file.  While the file is Work In Progress, you can change properties in there such as package name.
NOTE: package name is what your package will be called when published!
```lua
return {
	["packageName"] = "DemoPackage";
	["dependencies"] = {};
}
```

### Upcoming features:
- Ability to edit pre-existing packages.
- Better data upload methods.
- Bug fixes.
- Optimizations.
- Possible malicious code filter.
- And much more!
