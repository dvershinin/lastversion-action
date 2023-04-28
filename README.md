# lastversion-action

This GitHub Action uses the [`lastversion`](https://lastversion.getpagespeed.com/) command-line utility to fetch the latest stable version of any GitHub project 
or other software.

*Tremendously useful for continious integration and building your software against latest stable dependencies and avoid hardcoding of software versions in your workflows*.

## Inputs

### `repository`
Optional.
The GitHub repository or the name of the software for which you want to fetch the latest stable version. 
Example: `nginx` or `https://github.com/mautic/mautic`.
Defaults to GitHub repository of the current workflow.

### `action`
Optional. The action to perform:

* `get` to get the latest version string (default action).
* `unzip` to extract the latest release archive to the current directory.
* `download` to download the latest release archive to the current directory.

### `branch`
Optional. 
The branch to fetch the latest version from. Default is no branch filtering. Example: `mainline`.
Useful only for rare cases where a single repository hosts multiple software projects or version lines.
Can be also used to specify a major version, e.g. `2` or `2.0` to fetch the latest version of `2.x` branch.

### `output_format`
Optional. 
The output format for `get` action. 
Allowed values are: `version`, `json`, and `assets`. 
Default is `version`.

### `extra_args`
Optional. Any extra arguments to pass to the `lastversion` utility.

### `working_directory`

Change the working directory for the action. Default is the current directory.

## Outputs

### `last_version`

The latest stable version of the specified software or GitHub project. Or any other output, depending on the
`output_format` input.

## Usage

You can do a lot of useful things, but the primary use cases are:

* Download and extract the latest stable version of some software in your GitHub workflow
* Simply get the latest version string of some software for use in your GitHub workflow

### Downloading the latest stable version of software

To use this action in your GitHub workflow, add the following step:

```yaml
    steps:
      # ...
      - name: Download stable NGINX
        uses: dvershinin/lastversion-action@main
        with:
          repository: 'nginx'
          action: 'unzip'
          branch: 'stable'
      - name: Confirm NGINX source files are in the current directory
        run: ls -al
      # ...
```

At this point in your GitHub workflow, you have the latest stable version of NGINX downloaded and extracted in the
current directory.

### Getting the latest version string of some software

```yaml
    steps:
      # ...
      - name: Fetch latest version
        id: lastversion
        uses: dvershinin/lastversion-action@main
        with:
          repository: 'nginx'
          branch: 'mainline'
      - name: Print latest version
        run: echo "Latest version is ${{ steps.lastversion.outputs.last_version }}"
      # ...
```

In this example, the `Fetch latest version` step will fetch the latest version of NGINX from the mainline branch, and 
the `Print latest version` step will print the fetched version. You can adjust the inputs to fetch the latest version 
of other software or GitHub projects.

#### Example with GitHub repository

```yaml
    steps:
      # ...
      - name: Fetch latest version of Mautic
        id: lastversion
        uses: dvershinin/lastversion-action@main
        with:
          repository: 'https://github.com/mautic/mautic'  
      - name: Print latest version
        run: echo "Latest version of Mautic is ${{ steps.lastversion.outputs.last_version }}"
      # ...
```

In this example, the `Fetch latest version of Mautic` step will fetch the latest stable version of the Mautic project, 
and the `Print latest version` step will print the fetched version.
