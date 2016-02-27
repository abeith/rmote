Version 0.2
----------------------------------------------------------------------

- When the rmote server isn't running, restore default behavior of print methods
- Add `rmote_device()` function to allow control over plot dimensions, etc.
- Add `daemon = FALSE` option for potentially running a single dedicated rmote server for multiple R sessions on a remote server
- Add `rmote_mode()` to toggle rmote on / off (useful for `daemon = FALSE` option)
- Change start and stop to `rmote_start()` and `rmote_stop()`
- Make graphics look good on retina displays by default
- Use servr's new `httw()` function for live reloading
- Remove packages from depends and import
- Avoid use of `:::`