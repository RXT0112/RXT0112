# Packages

Directory dedicated to various packages that are expected to be processed by zernit

The packages are expected to be stored as `category/package`

invidual package version, slot, origin are expected to be stored as:

```
category/package-version:slot::origin
```

for the logic to be implemented as:

```
category/package-version:slot::origin OPTION: something -something
```

or

```
category/package-version:slot::origin \
	OPTION: something -something
```
