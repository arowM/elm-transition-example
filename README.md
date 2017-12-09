# elm-transition-example

## Summary

This project shows how to handle CSS transition as expected in Elm.

In [demo 1](https://arowm.github.io/elm-transition-example/index.html), a popup window would flash when tab B is selected.

This is caused by virtual DOM's optimization.
It reuses existing tags to rerender View, which unexpectedly fires CSS transition event.

[Demo 2](https://arowm.github.io/elm-transition-example/index2.html) uses correct way to use transition.
It wraps each Views of tab content with `unique` function, it is defined in [Main2.elm](https://github.com/arowM/elm-transition-example/blob/master/src/Main2.elm#L267), to enforce virtual DOM to recreate new tags instead of reusing existing tags.

## Build

```bash
$ yarn && yarn run build
```

## Start dev server

```bash
$ yarn && yarn start
```
