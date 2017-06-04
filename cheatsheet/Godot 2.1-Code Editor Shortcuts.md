# Godot 2.1 GDScript Editor Shortcuts

<!-- kbd select regex: ^(((Ctrl|Alt|Shift|F\d)\s?)+(\w+\d?|\=|\+)?)-->
<!-- alternative: (Ctrl|Shift|Alt|F\d|[0-9]|Space|Enter|Left|Right|Up|Down|\=|\-) -->

Godot’s code editor comes withahandful of powerful functions, all listed in its drop-down menus. Coding feels so much faster with them! That's whyImadealittle cheatsheet. If you don't know them yet, you'll want to learn most of them by heart.Iorganized the shortcuts in 5 categories below. The basic one includes keystrokes that are not specific to Godot, but that anyone making games should know.

You can edit Godot's shortcuts anytime in the top right corner of the editor. Click on `Settings`, `Editor Settings`, and head to the `Shortcuts` tab in the newly opened window.


## Basics

- <kbd>Shift</kbd><kbd>F1</kbd>: Search current selection in the reference
- <kbd>Ctrl</kbd><kbd>Shift</kbd><kbd>Alt</kbd><kbd>S</kbd>: Save all files
- <kbd>Ctrl</kbd><kbd>W</kbd>: Close the current file
- <kbd>Ctrl</kbd><kbd>Z</kbd> | <kbd>Ctrl</kbd><kbd>Y</kbd>: Undo, Redo
- <kbd>Ctrl</kbd><kbd>C</kbd> | <kbd>Ctrl</kbd><kbd>X</kbd>(_with text selected_): Copy selection, Cut selection
- <kbd>Ctrl</kbd><kbd>V</kbd>: Paste

**Move**:

- <kbd>Home</kbd> | <kbd>End</kbd>: Jump to start of line, Jump to end of line
- <kbd>Ctrl</kbd><kbd>Home</kbd> | <kbd>Ctrl</kbd><kbd>End</kbd>: Jump to start of document, Jump to end of document
- <kbd>Ctrl</kbd><kbd>Left</kbd> | <kbd>Ctrl</kbd><kbd>Right</kbd>: Jump to the previous word, Jump to the next word

**Select**:

- <kbd>Ctrl</kbd><kbd>A</kbd>: Select all
- <kbd>Shift</kbd><kbd>Home</kbd> | <kbd>Shift</kbd><kbd>End</kbd>: Select to start of line, Select to end of line
- <kbd>Ctrl</kbd><kbd>Shift</kbd><kbd>Home</kbd> | <kbd>Ctrl</kbd><kbd>Shift</kbd><kbd>End</kbd>: Select to start of document, Select to end of document

**Zoom/View**:

- <kbd>Shift</kbd><kbd>F11</kbd>: Distraction free mode
- <kbd>Ctrl</kbd><kbd>=</kbd> | <kbd>Ctrl</kbd><kbd>-</kbd>: Zoom in, Zoom out
- <kbd>Ctrl</kbd><kbd>0</kbd>: Reset zoom




## Line manipulation

**Copy and insert**:

- <kbd>Ctrl</kbd><kbd>Enter</kbd> | <kbd>Ctrl</kbd><kbd>Shift</kbd><kbd>Enter</kbd>: Insert line below, Insert line above
- <kbd>Ctrl</kbd><kbd>C</kbd> | <kbd>Ctrl</kbd><kbd>X</kbd>(_with no text selected_): Copy line, cut line
- <kbd>Ctrl</kbd><kbd>B</kbd>: Clone down

**Edit line**:

- <kbd>Alt</kbd><kbd>Up</kbd> | <kbd>Alt</kbd><kbd>Down</kbd>: Move line up, Move line down
- <kbd>Alt</kbd><kbd>Left</kbd> | <kbd>Alt</kbd><kbd>Right</kbd>: Unindent line, Indent line
- <kbd>Ctrl</kbd><kbd>I</kbd>: Auto indent (_indents lines following if statements_)
- <kbd>Ctrl</kbd><kbd>Alt</kbd><kbd>T</kbd>: Remove trailing whitespace
- <kbd>Ctrl</kbd><kbd>K</kbd>: Toggle comment


## Navigation

- <kbd>Ctrl</kbd><kbd>L</kbd>: Go to line
- <kbd>Ctrl</kbd><kbd>Shift</kbd><kbd>F</kbd>: Go to function
- <kbd>Ctrl</kbd><kbd>Alt</kbd><kbd>O</kbd>: Quick open script
- <kbd>Ctrl</kbd><kbd>Alt</kbd><kbd>Left</kbd> | <kbd>Ctrl</kbd><kbd>Alt</kbd><kbd>Right</kbd>: Navigate open file history


## Find and replace

- <kbd>Ctrl</kbd><kbd>F</kbd>: Find
- <kbd>Ctrl</kbd><kbd>R</kbd>: Search and replace
- <kbd>F3</kbd> | <kbd>Shift</kbd><kbd>F3</kbd>: Jump to next found occurence, Jump to previous found occurence
- <kbd>Ctrl</kbd><kbd>Space</kbd>: Open autocomplete suggestions


## Breakpoints

- <kbd>F9</kbd>: Toggle breakpoint
- <kbd>Ctrl</kbd><kbd>,</kbd>: Go to next breakpoint
- <kbd>Ctrl</kbd><kbd>.</kbd>: Go to previous breakpoint
- <kbd>Shift</kbd><kbd>Ctrl</kbd><kbd>F9</kbd>: Remove all breakpoints