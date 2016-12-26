# Themizer gem

## Summary

Provides methods which expands you regular SASS in rails into themed one using `&` operator and other cool SASS features.

## Installing

Add this to your Gemfile

`gem "themizer"`

and run

`bundle install`

## Usage

### Basic

#### Step 1

Put

```
Themizer.init(themes: ["dark", "contrast"])
```

somewhere in you initializers (e.g. `config/initializers/assets.rb`).

#### Step 2

Add classname to your `body` or `html`

```
<html class="dark">
```

#### Step 3

Put `<% Themizer.themize do %>` and `<% end %>` around block in your `.scss.erb` you wish to apply themes to and add `~` after name of customizing variables.

#### Step 4

Make SASS map out of definition of that variable.

Steps 3-4 would looks like changing this

```
$main-text-color: #333;

.someclass {
  color: $main-text-color~;
}
```

into this

```
$main-text-color: (
  "": #333,
  dark: #ccc,
  contrast: black,
);

<% Themizer.themize do %>
.someclass {
  color: $main-text-color~;
}
<% end %>
```

Now modified `.css.erb` would be compiled into `.scss`

```
.someclass {
  color: if(map-has-key($main-text-color, ""), map-get($main-text-color, ""), map-get($main-text-color, ""));
}

@each $theme in dark, contrast {
  .#{$theme} { &
    .someclass {
      color: if(map-has-key($main-text-color, $theme), map-get($main-text-color, $theme), map-get($main-text-color, ""));
    }
  }
}
```

which would be compiled into final `.css`

```
.someclass {
  color: #333;
}

.dark .someclass {
  color: #ccc;
}

.contrast .someclass {
  color: black;
}
```

Now, changing class of `<html>` will change `color` in `.someclass` block. Neat!

### More features

#### Using empty theme by default

If some theme in initializer is undefined in map, `Themizer` will apply empty theme (`""`)

```
$main-text-color: (
  "": #333,
  dark: #ccc,
);

<% Themizer.themize do %>
.someclass {
  color: $main-text-color~;
}
<% end %
```

=>


```
.someclass {
  color: #333;
}

.dark .someclass {
  color: #ccc;
}

.contrast .someclass {
  color: #333;
}
```

#### Transitive definitions

You can use transitive SASS variables definitions

```
$border-thickness: 1px;

$border-color: (
  "": white,
  dark: black,
  contrast: gray,
);

<% Themizer.themize do %>
$border: $border-thickness solid $border-color~;

.someclass {
  border: $border~;
}
<% end %>

```

=>

```
.someclass {
  border: 1px solid white;
}

.dark .someclass {
  border: 1px solid black;
}

.contrast .someclass {
  border: 1px solid gray;
}
```

#### unthemize()

You can undo theming for specific blocks

```
$white-white: (
  "": white,
  dark: black,
  contrast: gray,
);

<% Themizer.unthemize("dark") do %>
.someclass {
  color: $white-white~ !important;
}
<% end %>
```

=>

```
.someclass {
  color: black !important;
}

```

(unthemize uses `""` theme if none specified).


#### unthemize() transitive definitions

You can undo transitive definitions

```
$someclass-color: (
  "": white,
  dark: black,
  contrast: gray,
);

<% Themizer.unthemize do %>
$proxy: $someclass-color~;

.someclass {
  color: $proxy !important;
}
<% end %>
```

=>

```
.someclass {
  color: white !important;
}
```

## Caveats

### `body` theming

Approach used in this gem does work only for childs of DOM tree related to node where theme class was applied, therefore `*.scss.erb`

```
$body-bgcolor: (
  "": white,
  dark: gray,
  contrast: black,
);

<% Themizer.themize do %>
body {
  background-color: $body-bgcolor~;
}
<% end %>
```

will be compiled into

```
body {
  background-color: white;
}

.dark body {
  background-color: gray;
}

.contrast body {
  background-color: black;
}
```

and

```
<body class="dark">
```

won't be unable to change body itself.

Workaround 1: apply theme class to `<html>`.

Workaround 2: theme body separately without `themize()`.

### `themize do ... end` placing

`<% Themizer.themize do %>` and corresponding `<% end %>` should be placed in separate lines alone in order to parse properly.

### `Invalid CSS` error

Sometimes rails is facing an error which is inability to process `*css.erb` and raising error

```
Invalid CSS after "...r:#{sass_var_name}": expected ";", was "~;"
```

Workaround 1: `chmod 644 filename.css.erb`.

Workaround 2: remove and create anew problem files.

### Undefined `@themes` issue

Ssometimes, when under development env, spring don't correctly do `Themizer.init()`, which leads to lack of `@themes` variable and `Themizer.themize()` fails.

Workaround: restart rails.

## Debug

Initializing with `debug: true`

```
Themizer.init(themes: ["dark", "contrast"], debug: true)
```

will output processing block and resulting SASS to console.

## Testing

* `git clone`
* `bundle install`
* `rspec` or `rspec --tag spec00`

## TODO

* auto inverted-colors theme
* Haml support
* figure out spec16

## License

Themizer is distributed under the MIT-LICENSE.
