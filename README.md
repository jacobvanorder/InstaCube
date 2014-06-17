InstaCube
=========

A drop dead way to implement Color Cube in a CoreImage filter

The Color Cube Core Image filter is [woefully](https://developer.apple.com/library/mac/documentation/graphicsimaging/conceptual/CoreImaging/ci_filer_recipes/ci_filter_recipes.html) [undocumented](https://developer.apple.com/library/mac/documentation/graphicsimaging/reference/CoreImageFilterReference/Reference/reference.html#//apple_ref/doc/filter/ci/CIColorCube).

####So, let's talk about [Color Lookup Tables](http://en.wikipedia.org/wiki/Colour_look-up_table).

Essentially, if you were think of each RGBA value having a color associated with it, think of a dictionary (or a "lookup" "table") that has uses that RGBA value as a key which then returns a new value to use in it's place. 

The roots in LUTs come from computer graphics and video games in order to quickly alter the appearance of graphics without a heavy cost. In fact, it was [this article](http://udn.epicgames.com/Three/ColorGrading.html) that got the ball rolling. 

How so? Apple describes their color cube as this:

![color cube](https://raw.githubusercontent.com/jacobvanorder/InstaCube/master/Readme%20Images/appleCube.png)

But in actuality, it looks like this: 

![color strip](https://raw.githubusercontent.com/jacobvanorder/InstaCube/master/Readme%20Images/colorCube-16.png)

####Great.

InstaCube takes a key image, translates it to NSData that CIFilter Color Cube understands and set it to the correct InputKey that the CIFilter needs. 

What this means is that you take a generic key image like what's above and, using a photo editing application, apply color transformations that are uniform (think saturation, curves, levels, color multiplication) and not coordinate specific (think gradient, pattern overlay, masks, etc…). Afterwards, save the image, import and use with the following methods:

    + (CIFilter *)instaCubeWithKeyImageName:(NSString *)keyImageString onBundle:(NSBundle *)bundleOrNil;

    + (CIFilter *)instaCubeWithKeyImage:(UIImage *)keyImage;
    
The resulting CIFilter will be of the type ColorCube but still need an input image in order to get the resulting output image. 

####Questions, comments, suggestions?

[Email](mailto:jacob@sushigrass.com) or [Twitter](http://www.twitter.com/jacobvo)

