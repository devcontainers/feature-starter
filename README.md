# Dev Container Features starter template

🧰 Starter kit for your very own features monorepo

<p align=center>
  <img src="https://user-images.githubusercontent.com/61068799/261686846-6d45a663-80b2-47d0-bf21-7348ef4768e5.png">
</p>

<!-- prettier-ignore -->
[📖 Learn more about Dev Container Features](https://code.visualstudio.com/blogs/2022/09/15/dev-container-features) \
[📢 Give feedback on Dev Containers](https://github.com/devcontainers/spec/issues/61)

## Usage

<img align=right src="https://i.imgur.com/woHa37r.png">

**Click <kbd>Use this template</kbd>!** That's the first step. After
instantiating this template repo, there are a few things you'll need to do
manually:

1. Change the name in the `LICENSE` file to be your name or your organization's
   name. Right now it's `YOUR_NAME`.

2. Remove the top half of this readme. After reading it of course.

3. Change any of the other readme text to match your own new awesome feature
   collection. 🚀

Remember how you can use features like this?

```jsonc
// devcontainer.json
{
  "features": {
    "ghcr.io/devcontainers/features/node": {}
  }
}
```

Guess what? This is how those features are made! 🍰 This is a monorepo. There's
multiple features paired up with counterpart folders in `src/` and `test/`. For
example, the `hello` feature has a `src/hello/` folder with the
`devcontainer-feature.json` manifest file and the actual `install.sh` script
along with some tests in `test/hello/`. You can try out the tests and see
`hello` in action by running:

```sh
devcontainer features test -f hello
```

📚 For more information on how Dev Container Features work, check out some of
our [Guides]!

💡 Pro tip: All of the `options: { optionName: { ... } }` fields that you define
in the `devcontainer-feature.json` file will be mapped to env `$OPTIONNAME` vars
in `install.sh` so your installer script can respond to them. Here's a sample of
a `$VERSION` option that you might use to install a specific version of a tool:

```jsonc
{
  "options": {
    "version": {
      "type": "string",
      "default": "3.6.2"
    }
  }
}
```

<img align=right src="https://user-images.githubusercontent.com/61068799/261686950-0ba87a11-69dd-4841-ad5e-ba29b2af869a.png">

📕 You can find some more sample options in the `src/` of the demo features.

To publish your features, just run the <kbd>Publish features</kbd> workflow in
the <kbd>Actions</kbd> tab. This will automagically ✨ package and push your
Features to `ghcr.io/<you>/<your-repo>/*` so you can use them! You'll even see
them appear on the sidebar in the GitHub web UI.

After you've created your amazing feature collection, you might want to add it
to the official index so that it can be listed in autocomplete in tools like VS
Code and GitHub Codespaces. 🤩 Just
[open an Issue Form on the devcontainers/collections repo](https://github.com/devcontainers2/collections/issues/new?template=add-collection.yml)
and some magic will happen to add it to our index file.

<details><summary>License</summary>

Even though the `LICENSE` file in this repository says "YOUR_NAME", that's just
to be a good template. It's actually licensed under these terms:

```
MIT License

Copyright (c) 2022 Microsoft Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

</details>

---

<!-- REMOVE EVERYTHING THIS LINE AND ABOVE -->

# My awesome Dev Container Features

🤩 My collection of awesome Dev Container Features

<p align=center>
  <img width=400 src="https://i.imgur.com/7iCBFSC.png">
</p>

[↗️ See all features at containers.dev/features](https://containers.dev/features)

## Usage

```jsonc
"features": {
  "ghcr.io/octocat/my-awesome-features/<feature-id>": {}
}
```

## Development

![GitHub Actions](https://img.shields.io/static/v1?style=for-the-badge&message=GitHub+Actions&color=2088FF&logo=GitHub+Actions&logoColor=FFFFFF&label=)
![Codespaces](https://img.shields.io/static/v1?style=for-the-badge&message=Codespaces&color=181717&logo=GitHub&logoColor=FFFFFF&label=)
![Devcontainers](https://img.shields.io/static/v1?style=for-the-badge&message=Devcontainers&color=2496ED&logo=Docker&logoColor=FFFFFF&label=)

To test a specific feature, you can use the `devcontainer` CLI:

```sh
devcontainer features test -f <feature-id>
```

Someone with appropriate access must manually trigger the <kbd>Publish
features</kbd> workflow to create a new release.
