InstaCube
=========

A drop dead way to implement Color Cube in a CoreImage filter

The Color Cube Core Image filter is [woefully](https://developer.apple.com/library/mac/documentation/graphicsimaging/conceptual/CoreImaging/ci_filer_recipes/ci_filter_recipes.html) [undocumented](https://developer.apple.com/library/mac/documentation/graphicsimaging/reference/CoreImageFilterReference/Reference/reference.html#//apple_ref/doc/filter/ci/CIColorCube).

###So, let's talk about [Color Lookup Tables](http://en.wikipedia.org/wiki/Colour_look-up_table).

Essentially, if you were think of each RGBA value having a color associated with it, think of a dictionary (or a "lookup" "table") that has uses that RGBA value as a key which then returns a new value to use in it's place. 



