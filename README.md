# lastversion-action

This GitHub Action uses the `lastversion` command-line utility to fetch the latest stable version of any GitHub project 
or other software.

## Inputs

### `repository`
**Required**. The GitHub repository or the name of the software for which you want to fetch the latest stable version. 
Example: nginx or https://github.com/mautic/mautic.

### `branch`
Optional. The branch to fetch the latest version from. Default is no branch filtering. Example: mainline.

### `output_format`
Optional. The output format for the results. Allowed values are: version, json, and assets. Default is version.

### `extra_args`
Optional. Any extra arguments to pass to the lastversion utility.

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
jobs:
  hello_world_job:
    runs-on: ubuntu-latest
    name: A job to say hello
    steps:
      - name: Download stable NGINX
        uses: dvershinin/lastversion-action@main
        with:
          repository: 'nginx'
          action: 'unzip'
          branch: 'stable'
      - name: What do we have here
        run: ls -al
```

At this point in your GitHub workflow, you have the latest stable version of NGINX downloaded and extracted in the
current directory.

### Getting the latest version string of some software

```yaml
steps:
  - name: Checkout repository
    uses: actions/checkout@v2

  - name: Fetch latest version
    id: lastversion
    uses: dvershinin/lastversion-action@main
    with:
      repository: 'nginx'
      branch: 'mainline'
      output_format: 'version'

  - name: Print latest version
    run: echo "Latest version is ${{ steps.lastversion.outputs.last_version }}"
```

In this example, the `Fetch latest version` step will fetch the latest version of Nginx from the mainline branch, and 
the `Print latest version` step will print the fetched version. You can adjust the inputs to fetch the latest version 
of other software or GitHub projects.

#### Example with GitHub repository

```yaml
steps:
  - name: Checkout repository
    uses: actions/checkout@v2

  - name: Fetch latest version of Mautic
    id: lastversion
    uses: dvershinin/lastversion-action@main
    with:
      repository: 'https://github.com/mautic/mautic'
      output_format: 'version'

  - name: Print latest version
    run: echo "Latest version of Mautic is ${{ steps.lastversion.outputs.last_version }}"
```

In this example, the `Fetch latest version of Mautic` step will fetch the latest stable version of the Mautic project, 
and the `Print latest version` step will print the fetched version.
