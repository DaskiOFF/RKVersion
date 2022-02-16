# RKVersion

Contains struct `Version` for comparing versions.

## Using

### Create instance of `Version`

`try Version(raw: "1.1.1")` or `try Version(raw: "1,2,1", separator: ",")`

### Compare versions

```
let version1 = try Version("1.1.1")
let version2 = try Version("1.1.2")

if (version1 < version2) {
    // do smth
}
```
